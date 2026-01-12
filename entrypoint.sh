#!/usr/bin/env bash
set -euo pipefail

PGURI="${DATABASE_URL:?DATABASE_URL not set}"

psql "$PGURI" -v ON_ERROR_STOP=1 <<'SQL'
DO $$
DECLARE
  r RECORD;
  n BIGINT;
BEGIN
  FOR r IN
    SELECT table_schema, table_name
    FROM information_schema.columns
    WHERE column_name = 'expires_at'
      AND table_schema = 'public'
  LOOP
    EXECUTE format(
      'DELETE FROM %I.%I WHERE expires_at < now()',
      r.table_schema, r.table_name
    );
    GET DIAGNOSTICS n = ROW_COUNT;
    RAISE NOTICE 'Cleaned %.% -> % rows', r.table_schema, r.table_name, n;
  END LOOP;
END $$;
SQL
