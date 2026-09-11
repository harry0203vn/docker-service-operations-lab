# Health Checks and Logging

## `scripts/health_check.sh`

Checks whether the portal is reachable at `http://localhost:8090` and records the result.

Logic:

1. Sends an HTTP request with `curl -fsS -o /dev/null -w "%{http_code}" --max-time 5 http://localhost:8090`.
2. If curl succeeds **and** the returned HTTP status code is exactly `200`, the check counts as success.
3. Otherwise (connection refused, timeout after 5 seconds, or any non-200 status) the check counts as failure.
4. Either way, a timestamped line is appended to `logs/healthcheck.log`:
   - `YYYY-MM-DD HH:MM:SS OK` on success
   - `YYYY-MM-DD HH:MM:SS FEHLER` on failure
5. The script also prints a short human-readable message to the terminal and exits with `0` on success or `1` on failure, so it can be used in automation (e.g. a cron job or CI step) that reacts to the exit code.

The script deliberately does **not** use `set -e`, because a failed `curl` call (service unreachable) is an expected, handled outcome here — not a script bug — and must not abort the script before the log line is written.

### Real log example

An actual run of the project produced the following `logs/healthcheck.log` (Testfall 1 → Testfall 2 → Testfall 3, see [`testing.md`](testing.md)):

```
2026-09-09 09:59:02 OK
2026-09-09 10:01:57 FEHLER
2026-09-09 10:03:15 OK
```

This shows the service was reachable, then briefly stopped (correctly logged as `FEHLER`), then reachable again after being restarted.

## `scripts/report_generator.py`

Reads `logs/healthcheck.log` line by line and produces `reports/betriebsreport.txt`.

Logic:

1. If the log file does not exist yet, the script prints a helpful hint ("run `health_check.sh` at least once first") and exits with `1` instead of crashing.
2. Each non-empty line is classified by its trailing word: lines ending in `OK` increment an OK counter, lines ending in `FEHLER` increment an error counter, and unrecognized lines are simply skipped so a single malformed line cannot crash the report.
3. The **last** classified line determines the "last known status".
4. A short recommendation is derived from the last status and the error count:
   - No usable entries at all → *"No evaluable entries present — check the health check."*
   - Last status `OK` and zero errors ever → *"Service is running stably."*
   - Last status `OK` but at least one earlier `FEHLER` → *"Service is currently running, but there were earlier failures — check the history."*
   - Last status `FEHLER` → *"Check the service."*
5. The result is written to `reports/betriebsreport.txt`.

### Real report example

Generated from the log example above:

```
Projekt: Nordstern Webportal (Projekt 5 - Docker Service Betrieb)
Report erzeugt am: 2026-09-09 10:03:19

Anzahl erfolgreicher Healthchecks (OK): 2
Anzahl fehlgeschlagener Healthchecks (FEHLER): 1
Letzter bekannter Status: OK

Empfehlung: Dienst laeuft aktuell, es gab jedoch fruehere Fehler - Verlauf pruefen.
```

(The report content itself is generated in German, matching the original assignment's language; the counts and recommendation logic are exactly as described above — here "1 earlier failure, last status OK" correctly triggers the "running now, but check history" recommendation.)
