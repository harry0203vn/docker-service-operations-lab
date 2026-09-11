# Testing

Three real test cases were executed against a live Docker environment (Docker Desktop with WSL Ubuntu integration). All three produced the log and report data shown in [`health-checks-and-logging.md`](health-checks-and-logging.md).

## Test Case 1 — Normal operation

**Objective:** Verify that the service starts correctly and the health check reports success while it is running.

**Procedure:**
1. `./scripts/service_control.sh start`
2. Confirm in a browser that the portal loads at `http://localhost:8090`.
3. `./scripts/health_check.sh`

**Expected result:** The portal is reachable, the script prints a success message, exits with code `0`, and appends an `OK` line to `logs/healthcheck.log`.

**Observed result:** ✅ Passed. The portal loaded correctly, and `logs/healthcheck.log` received the entry `2026-09-09 09:59:02 OK`.

**Evidence:** `evidence/screenshots/` (browser screenshot of the running portal; see [`evidence/README.md`](../evidence/README.md) for exactly which screenshots are included in this repository and why).

## Test Case 2 — Stopped service (failure case)

**Objective:** Verify that the health check correctly detects and logs a failure when the service is not running, and returns a non-zero exit code, instead of silently succeeding or crashing.

**Procedure:**
1. `./scripts/service_control.sh stop`
2. `./scripts/health_check.sh`

**Expected result:** curl cannot reach `http://localhost:8090`; the script prints a failure message, exits with code `1`, and appends a `FEHLER` line to `logs/healthcheck.log`.

**Observed result:** ✅ Passed. With the container stopped, the health check correctly logged `2026-09-09 10:01:57 FEHLER` and returned exit code `1` instead of raising an unhandled error — this specifically validates the decision not to use `set -e` in `health_check.sh`, since a failed `curl` call here is an expected condition that must still be logged, not an abort condition.

**Evidence:** Terminal output of the failed health check (see [`evidence/README.md`](../evidence/README.md) for which terminal screenshots could be safely included).

## Test Case 3 — Operational report generation

**Objective:** Verify that `report_generator.py` correctly aggregates a mixed history of `OK` and `FEHLER` entries into an accurate, human-readable report.

**Procedure:**
1. `./scripts/service_control.sh start` (bring the service back up after Test Case 2)
2. `./scripts/health_check.sh` (record a fresh `OK` entry)
3. `python3 scripts/report_generator.py`
4. `cat reports/betriebsreport.txt`

**Expected result:** The report correctly counts 2 `OK` entries and 1 `FEHLER` entry from the accumulated log, identifies `OK` as the last known status, and — because there was an earlier failure despite the current success — recommends checking the history rather than simply reporting "stable".

**Observed result:** ✅ Passed. The service was restarted and reachable again (`2026-09-09 10:03:15 OK`), and the generated report exactly matched the expected counts and recommendation (see the real report content in [`health-checks-and-logging.md`](health-checks-and-logging.md)).

**Evidence:** Terminal output of the report generation and the resulting `betriebsreport.txt` content (see [`evidence/README.md`](../evidence/README.md)).

## Summary

| # | Test case | Result |
|---|---|---|
| 1 | Normal operation | ✅ Passed |
| 2 | Stopped service / failure detection | ✅ Passed |
| 3 | Report generation | ✅ Passed |

All three test cases were run against the real `docker-compose.yml` in this repository, with no modifications to the scripts between the original test run and this repository's content.
