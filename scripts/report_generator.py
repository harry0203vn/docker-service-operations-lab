#!/usr/bin/env python3
"""
report_generator.py

Liest logs/healthcheck.log und erzeugt daraus reports/betriebsreport.txt
mit einer kurzen Zusammenfassung des Betriebszustands.

Projekt 5: Docker Service Betrieb mit Bash und Python (Nordstern Services GmbH)

Erwartetes Log-Zeilenformat (wird von health_check.sh so geschrieben):
    YYYY-MM-DD HH:MM:SS OK
    YYYY-MM-DD HH:MM:SS FEHLER
"""

from __future__ import annotations

import sys
from datetime import datetime
from pathlib import Path

PROJECT_NAME = "Nordstern Webportal (Projekt 5 - Docker Service Betrieb)"

SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_DIR = SCRIPT_DIR.parent
LOG_FILE = PROJECT_DIR / "logs" / "healthcheck.log"
REPORT_DIR = PROJECT_DIR / "reports"
REPORT_FILE = REPORT_DIR / "betriebsreport.txt"


def parse_log_lines(lines: list[str]) -> tuple[int, int, str | None]:
    """Zaehlt OK/FEHLER-Eintraege und ermittelt den letzten bekannten Status."""
    ok_count = 0
    error_count = 0
    last_status: str | None = None

    for raw_line in lines:
        line = raw_line.strip()
        if not line:
            continue

        if line.endswith("OK"):
            ok_count += 1
            last_status = "OK"
        elif line.endswith("FEHLER"):
            error_count += 1
            last_status = "FEHLER"
        # Unbekannte/fehlerhafte Zeilen werden ignoriert, aber nicht das
        # gesamte Skript zum Absturz gebracht.

    return ok_count, error_count, last_status


def build_recommendation(last_status: str | None, ok_count: int, error_count: int) -> str:
    if last_status is None:
        return "Keine auswertbaren Eintraege vorhanden - Healthcheck pruefen."
    if last_status == "OK" and error_count == 0:
        return "Dienst laeuft stabil."
    if last_status == "OK" and error_count > 0:
        return "Dienst laeuft aktuell, es gab jedoch fruehere Fehler - Verlauf pruefen."
    return "Dienst pruefen."


def generate_report() -> int:
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    if not LOG_FILE.exists():
        print(
            f"Hinweis: Logdatei nicht gefunden unter {LOG_FILE}. "
            "Bitte zuerst health_check.sh mindestens einmal ausfuehren, "
            "bevor der Betriebsreport erzeugt wird."
        )
        return 1

    try:
        lines = LOG_FILE.read_text(encoding="utf-8").splitlines()
    except OSError as exc:
        print(f"Fehler beim Lesen der Logdatei {LOG_FILE}: {exc}")
        return 1

    ok_count, error_count, last_status = parse_log_lines(lines)
    recommendation = build_recommendation(last_status, ok_count, error_count)

    REPORT_DIR.mkdir(parents=True, exist_ok=True)

    report_lines = [
        f"Projekt: {PROJECT_NAME}",
        f"Report erzeugt am: {now_str}",
        "",
        f"Anzahl erfolgreicher Healthchecks (OK): {ok_count}",
        f"Anzahl fehlgeschlagener Healthchecks (FEHLER): {error_count}",
        f"Letzter bekannter Status: {last_status if last_status else 'unbekannt'}",
        "",
        f"Empfehlung: {recommendation}",
    ]

    REPORT_FILE.write_text("\n".join(report_lines) + "\n", encoding="utf-8")

    print(f"Betriebsreport erstellt: {REPORT_FILE}")
    return 0


if __name__ == "__main__":
    sys.exit(generate_report())
