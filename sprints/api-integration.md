# API Integration Sprint — External Service Connection

> **Version:** 1.0.0

## Purpose
Sprint for integrating with an external API or service. Covers research,
client implementation, error handling, and integration testing.

## Tasks

### Task 1: API Research
- **Worker:** researcher
- **Input:** Integration requirement (which service, what data/actions needed)
- **Process:**
  1. Read the external API documentation thoroughly.
  2. Document authentication requirements.
  3. Document rate limits, quotas, and pricing implications.
  4. Identify the specific endpoints needed.
  5. Note data formats, pagination patterns, and error response shapes.
- **Output:** API research document with endpoint catalog, auth requirements, and sample requests/responses.
- **Verification:** Every needed endpoint documented with method, path, params, and response shape.

### Task 2: Client Design
- **Worker:** architect
- **Input:** API research from Task 1
- **Process:**
  1. Design the client module structure (wrapper, types, error handling).
  2. Define the internal interface (how the rest of the app calls this client).
  3. Plan retry logic, timeout handling, and circuit-breaking if applicable.
  4. Design the configuration approach (env vars, config file).
- **Output:** Client architecture with interface definitions and error handling strategy.
- **Verification:** Internal interface is clean and doesn't leak external API details.

### Task 3: Implementation
- **Worker:** coder
- **Input:** Client design from Task 2 + API research from Task 1
- **Process:**
  1. Implement the client module with typed request/response interfaces.
  2. Implement error handling (network errors, rate limits, auth failures, unexpected responses).
  3. Write unit tests with mocked API responses (happy path + error paths).
  4. Implement configuration loading.
- **Output:** Client code + unit tests + configuration schema.
- **Verification:** Unit tests pass with mocked responses. Types are correct. Error paths handled.

### Task 4: Integration Testing
- **Worker:** qa-engineer
- **Input:** Implemented client + API research from Task 1
- **Process:**
  1. Test against the actual API (or a sandbox/staging environment).
  2. Verify real responses match documented shapes.
  3. Test error handling with intentionally bad requests.
  4. Test rate limit behavior if applicable.
  5. Measure response times and document latency characteristics.
- **Output:** Integration test results with actual API responses, timing data, and error handling evidence.
- **Verification:** Real API responses match expected shapes. Errors handled gracefully. Latency documented.

### Task 5: Verification
- **Worker:** reviewer
- **Input:** All outputs from Tasks 1–4
- **Process:**
  1. Review client code for security (credentials not hardcoded, HTTPS enforced).
  2. Check error handling completeness (all documented error codes handled).
  3. Verify the internal interface doesn't expose implementation details.
  4. Confirm integration tests use real (not mocked) responses.
- **Output:** Review verdict with security and completeness findings.
- **Verification:** No security issues. Error handling covers all documented API error codes.

## Completion Criteria
- Client module complete with typed interfaces.
- Unit tests pass with mocked responses.
- Integration tests pass against real/sandbox API.
- Error handling covers all documented failure modes.
- No credentials hardcoded.
