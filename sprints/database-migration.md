# Database Migration Sprint — Schema Change Management

> **Version:** 1.0.0

## Purpose
Sprint for making database schema changes safely. Covers migration design,
implementation, data preservation verification, and rollback planning.

## Tasks

### Task 1: Migration Design
- **Worker:** architect
- **Input:** Required schema change + current schema
- **Process:**
  1. Document current schema state.
  2. Design the target schema.
  3. Plan the migration steps (add column, migrate data, drop old column, etc.).
  4. Design the rollback procedure (every migration must be reversible).
  5. Identify data at risk and plan preservation checks.
- **Output:** Migration plan with current state, target state, steps, and rollback procedure.
- **Verification:** Rollback procedure defined. Data preservation strategy documented.

### Task 2: Migration Implementation
- **Worker:** coder
- **Input:** Migration plan from Task 1
- **Process:**
  1. Write the migration script (up and down).
  2. Write data preservation assertions (row counts, checksums, key relationships).
  3. Update ORM models / type definitions to match new schema.
  4. Update queries and data access code.
- **Output:** Migration files + updated models + data preservation tests.
- **Verification:** Migration runs. Down migration reverses it. Models match new schema.

### Task 3: Verification
- **Worker:** qa-engineer
- **Input:** Migration + test database with representative data
- **Process:**
  1. Run migration on test database with sample data.
  2. Verify data preservation (row counts, checksums, relationships intact).
  3. Run rollback — verify database returns to original state.
  4. Run the application's full test suite against the migrated schema.
  5. Test with edge-case data (nulls, large values, unicode, foreign key chains).
- **Output:** Migration test results + data preservation evidence + rollback evidence.
- **Verification:** Data preserved. Rollback works. All tests pass on migrated schema.

## Completion Criteria
- Migration runs successfully.
- Data preservation verified with concrete evidence.
- Rollback tested and working.
- Application tests pass on new schema.
