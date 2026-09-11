# Troubleshooting / Lessons Learned

Real issues encountered while building and operating this project, and how they were resolved.

## 1. No official web content was available for the portal

**Issue:** The original assignment described a fictional company ("Nordstern Services GmbH") and referred to "provided web files" as example content for the portal, but no such file package existed anywhere in the course materials — a thorough search of the entire course folder (by filename and by content, including terms like "webportal", "Nordstern", and general `*.html`/`*.css`/`*.js` files) turned up nothing that matched Project 5. The only HTML file found anywhere in the course materials was an unrelated Nginx exercise file from an earlier, different assignment, and it was not a fit content-wise for this project.

**Resolution:** A small, self-made placeholder website (`webportal/index.html`, `webportal/style.css`) was created from scratch, matching the fictional company described in the assignment text. It contains no real personal or organizational data and is clearly a stand-in for whatever content a real deployment would serve.

**Lesson:** When an assignment references "provided" assets that turn out not to exist, document the search that was done and build a clearly-labeled placeholder rather than guessing at unrelated content or leaving the service unable to run.

## 2. `curl` failing must be treated as a valid outcome, not a script error

**Issue:** An early version of the health-check logic risked aborting entirely (via `set -e`) whenever the portal was unreachable, which would have prevented the failure from ever being logged — exactly the case the health check exists to catch.

**Resolution:** `health_check.sh` intentionally omits `set -e` and instead checks curl's exit status and the returned HTTP code explicitly, so an unreachable service is captured as a normal, logged `FEHLER` entry with exit code `1`, rather than crashing the script.

**Lesson:** For a health-check script specifically, "the thing being checked has failed" must be a first-class, handled code path — not an exception that aborts the script before the failure is even logged.

## 3. Missing log file on first run of the report generator

**Issue:** Running `report_generator.py` before `health_check.sh` had ever been executed would otherwise fail with an unhandled file-not-found error.

**Resolution:** The script explicitly checks whether `logs/healthcheck.log` exists before trying to read it, and if not, prints a clear instruction to run `health_check.sh` first and exits cleanly with status `1` instead of a raw traceback.

**Lesson:** Scripts that depend on another script having run first should detect that precondition directly and explain it, rather than surfacing a generic runtime error.
