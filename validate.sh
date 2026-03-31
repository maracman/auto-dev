#!/usr/bin/env bash
# validate.sh — Automated Validation Runner
#
# Utility script called by worker agents during sprint execution.
# Auto-detects the project's toolchain and runs the appropriate checks.
#
# Usage:
#   ./validate.sh baseline    # Capture starting scores
#   ./validate.sh full        # Run all applicable checks
#   ./validate.sh lint        # Lint + format + type-check only
#   ./validate.sh test        # Unit tests only
#   ./validate.sh integration # Integration tests only
#   ./validate.sh visual      # Visual regression only
#   ./validate.sh build       # Build only
#
# Override any command via .auto-dev.env in the project root.
# This file is part of the pipeline — Main agent may modify it.

set -euo pipefail

# ─── Configuration ───────────────────────────────────────────────────────────

if [[ -f .auto-dev.env ]]; then
  source .auto-dev.env
fi

LINT_CMD="${LINT_CMD:-}"
FORMAT_CHECK_CMD="${FORMAT_CHECK_CMD:-}"
TYPE_CHECK_CMD="${TYPE_CHECK_CMD:-}"
UNIT_TEST_CMD="${UNIT_TEST_CMD:-}"
INTEGRATION_TEST_CMD="${INTEGRATION_TEST_CMD:-}"
VISUAL_TEST_CMD="${VISUAL_TEST_CMD:-}"
BUILD_CMD="${BUILD_CMD:-}"
RESULTS_DIR="${RESULTS_DIR:-.auto-dev-results}"

# ─── Auto-detection ──────────────────────────────────────────────────────────

detect_toolchain() {
  if [[ -f package.json ]]; then
    RUNTIME="node"
    PKG_MANAGER="npm"
    [[ -f pnpm-lock.yaml ]] && PKG_MANAGER="pnpm"
    [[ -f yarn.lock ]] && PKG_MANAGER="yarn"
    [[ -f bun.lockb ]] && PKG_MANAGER="bun"

    local scripts
    scripts=$(cat package.json)

    [[ -z "$LINT_CMD" ]] && echo "$scripts" | grep -q '"lint"' && LINT_CMD="$PKG_MANAGER run lint 2>&1" || true
    [[ -z "$FORMAT_CHECK_CMD" ]] && echo "$scripts" | grep -q '"format:check"' && FORMAT_CHECK_CMD="$PKG_MANAGER run format:check 2>&1" || true
    [[ -z "$TYPE_CHECK_CMD" ]] && [[ -f tsconfig.json ]] && TYPE_CHECK_CMD="npx tsc --noEmit 2>&1" || true
    [[ -z "$UNIT_TEST_CMD" ]] && echo "$scripts" | grep -q '"test"' && UNIT_TEST_CMD="$PKG_MANAGER test 2>&1" || true
    [[ -z "$INTEGRATION_TEST_CMD" ]] && echo "$scripts" | grep -q '"test:integration"' && INTEGRATION_TEST_CMD="$PKG_MANAGER run test:integration 2>&1" || true
    [[ -z "$VISUAL_TEST_CMD" ]] && echo "$scripts" | grep -q '"test:visual"' && VISUAL_TEST_CMD="$PKG_MANAGER run test:visual 2>&1" || true
    [[ -z "$BUILD_CMD" ]] && echo "$scripts" | grep -q '"build"' && BUILD_CMD="$PKG_MANAGER run build 2>&1" || true

  elif [[ -f pyproject.toml ]] || [[ -f setup.py ]] || [[ -f requirements.txt ]]; then
    RUNTIME="python"
    [[ -z "$LINT_CMD" ]] && command -v ruff &>/dev/null && LINT_CMD="ruff check . 2>&1" || true
    [[ -z "$FORMAT_CHECK_CMD" ]] && command -v ruff &>/dev/null && FORMAT_CHECK_CMD="ruff format --check . 2>&1" || true
    [[ -z "$TYPE_CHECK_CMD" ]] && command -v mypy &>/dev/null && TYPE_CHECK_CMD="mypy . 2>&1" || true
    [[ -z "$UNIT_TEST_CMD" ]] && command -v pytest &>/dev/null && UNIT_TEST_CMD="pytest --tb=short 2>&1" || true
    [[ -z "$INTEGRATION_TEST_CMD" ]] && command -v pytest &>/dev/null && INTEGRATION_TEST_CMD="pytest -m integration --tb=short 2>&1" || true

  elif [[ -f go.mod ]]; then
    RUNTIME="go"
    [[ -z "$LINT_CMD" ]] && command -v golangci-lint &>/dev/null && LINT_CMD="golangci-lint run 2>&1" || true
    [[ -z "$UNIT_TEST_CMD" ]] && UNIT_TEST_CMD="go test ./... 2>&1" || true
    [[ -z "$BUILD_CMD" ]] && BUILD_CMD="go build ./... 2>&1" || true

  elif [[ -f Cargo.toml ]]; then
    RUNTIME="rust"
    [[ -z "$LINT_CMD" ]] && LINT_CMD="cargo clippy -- -D warnings 2>&1" || true
    [[ -z "$FORMAT_CHECK_CMD" ]] && FORMAT_CHECK_CMD="cargo fmt -- --check 2>&1" || true
    [[ -z "$UNIT_TEST_CMD" ]] && UNIT_TEST_CMD="cargo test 2>&1" || true
    [[ -z "$BUILD_CMD" ]] && BUILD_CMD="cargo build 2>&1" || true

  else
    RUNTIME="unknown"
    echo "Warning: Could not auto-detect toolchain. Set commands in .auto-dev.env"
  fi
}

# ─── Runner ──────────────────────────────────────────────────────────────────

mkdir -p "$RESULTS_DIR"

run_step() {
  local name="$1"
  local cmd="$2"
  local output_file="${RESULTS_DIR}/${name}.log"

  if [[ -z "$cmd" ]]; then
    echo "  skip: ${name} (no command configured)"
    echo '{"status":"skipped"}' > "${RESULTS_DIR}/${name}.json"
    return 0
  fi

  echo "  run:  ${name}"
  local exit_code=0
  eval "$cmd" > "$output_file" 2>&1 || exit_code=$?

  local warnings=0 tests_passed=0 tests_failed=0
  if [[ -f "$output_file" ]]; then
    warnings=$(grep -ciE '(warning|warn)' "$output_file" 2>/dev/null || echo 0)
    tests_passed=$(grep -oE '([0-9]+) (passed|pass)' "$output_file" 2>/dev/null | head -1 | grep -oE '^[0-9]+' || echo 0)
    tests_failed=$(grep -oE '([0-9]+) (failed|fail)' "$output_file" 2>/dev/null | head -1 | grep -oE '^[0-9]+' || echo 0)
  fi

  local status="pass"
  [[ $exit_code -ne 0 ]] && status="fail"

  cat > "${RESULTS_DIR}/${name}.json" <<EOF
{"status":"${status}","exit_code":${exit_code},"warnings":${warnings},"tests_passed":${tests_passed},"tests_failed":${tests_failed}}
EOF

  [[ $exit_code -ne 0 ]] && echo "  FAIL: ${name} (exit ${exit_code})" || echo "  pass: ${name}"
  return $exit_code
}

# ─── Aggregation ─────────────────────────────────────────────────────────────

aggregate() {
  local total_warnings=0 total_passed=0 total_failed=0 all_pass=true

  for f in "${RESULTS_DIR}"/*.json; do
    [[ "$(basename "$f")" =~ ^(baseline|aggregate)\.json$ ]] && continue
    local status warnings tp tf
    status=$(python3 -c "import json; print(json.load(open('$f')).get('status','skipped'))" 2>/dev/null || echo "skipped")
    warnings=$(python3 -c "import json; print(json.load(open('$f')).get('warnings',0))" 2>/dev/null || echo 0)
    tp=$(python3 -c "import json; print(json.load(open('$f')).get('tests_passed',0))" 2>/dev/null || echo 0)
    tf=$(python3 -c "import json; print(json.load(open('$f')).get('tests_failed',0))" 2>/dev/null || echo 0)
    total_warnings=$((total_warnings + warnings))
    total_passed=$((total_passed + tp))
    total_failed=$((total_failed + tf))
    [[ "$status" == "fail" ]] && all_pass=false
  done

  local overall="pass"
  $all_pass || overall="fail"

  cat > "${RESULTS_DIR}/aggregate.json" <<EOF
{"overall":"${overall}","total_warnings":${total_warnings},"tests_passed":${total_passed},"tests_failed":${total_failed},"timestamp":"$(date -u +%Y-%m-%dT%H:%M:%SZ)"}
EOF

  echo ""
  echo "=== ${overall^^} === tests: ${total_passed} pass / ${total_failed} fail | warnings: ${total_warnings}"
  $all_pass
}

# ─── Main ────────────────────────────────────────────────────────────────────

main() {
  local mode="${1:-full}"
  detect_toolchain
  echo "runtime: ${RUNTIME:-unknown}"

  case "$mode" in
    baseline)
      run_step "lint" "$LINT_CMD" || true
      run_step "format" "$FORMAT_CHECK_CMD" || true
      run_step "typecheck" "$TYPE_CHECK_CMD" || true
      run_step "unit_tests" "$UNIT_TEST_CMD" || true
      run_step "build" "$BUILD_CMD" || true
      aggregate || true
      cp "${RESULTS_DIR}/aggregate.json" "${RESULTS_DIR}/baseline.json"
      echo "baseline saved"
      ;;
    lint)
      run_step "lint" "$LINT_CMD" || true
      run_step "format" "$FORMAT_CHECK_CMD" || true
      run_step "typecheck" "$TYPE_CHECK_CMD" || true
      aggregate
      ;;
    test)
      run_step "unit_tests" "$UNIT_TEST_CMD"
      aggregate
      ;;
    integration)
      run_step "integration_tests" "$INTEGRATION_TEST_CMD"
      aggregate
      ;;
    visual)
      run_step "visual_tests" "$VISUAL_TEST_CMD"
      aggregate
      ;;
    build)
      run_step "build" "$BUILD_CMD"
      aggregate
      ;;
    full)
      run_step "lint" "$LINT_CMD" || true
      run_step "format" "$FORMAT_CHECK_CMD" || true
      run_step "typecheck" "$TYPE_CHECK_CMD" || true
      run_step "unit_tests" "$UNIT_TEST_CMD" || true
      run_step "integration_tests" "$INTEGRATION_TEST_CMD" || true
      run_step "visual_tests" "$VISUAL_TEST_CMD" || true
      run_step "build" "$BUILD_CMD" || true
      aggregate
      ;;
    *)
      echo "Usage: ./validate.sh [baseline|full|lint|test|integration|visual|build]"
      exit 1
      ;;
  esac
}

main "$@"
