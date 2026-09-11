# Tests

Drei reale Testfälle wurden gegen eine laufende Docker-Umgebung ausgeführt (Docker Desktop mit WSL-Ubuntu-Integration). Alle drei erzeugten die Log- und Reportdaten, die in [`health-checks-and-logging.md`](health-checks-and-logging.md) gezeigt werden.

## Testfall 1 — Normalbetrieb

**Ziel:** Prüfen, dass der Dienst korrekt startet und der Health Check bei laufendem Dienst Erfolg meldet.

**Ablauf:**
1. `./scripts/service_control.sh start`
2. Im Browser bestätigen, dass das Portal unter `http://localhost:8090` lädt.
3. `./scripts/health_check.sh`

**Erwartetes Ergebnis:** Das Portal ist erreichbar, das Skript gibt eine Erfolgsmeldung aus, beendet sich mit Exit-Code `0` und hängt eine `OK`-Zeile an `logs/healthcheck.log` an.

**Beobachtetes Ergebnis:** ✅ Bestanden. Das Portal lud korrekt, und `logs/healthcheck.log` erhielt den Eintrag `2026-09-09 09:59:02 OK`.

**Nachweis:** `evidence/screenshots/` (Browser-Screenshot des laufenden Portals; siehe [`evidence/README.md`](../evidence/README.md) für die genaue Auswahl der in diesem Repository enthaltenen Screenshots und die Gründe dafür).

## Testfall 2 — Gestoppter Dienst (Fehlerfall)

**Ziel:** Prüfen, dass der Health Check korrekt erkennt und protokolliert, wenn der Dienst nicht läuft, und einen von Null verschiedenen Exit-Code liefert, statt stillschweigend erfolgreich zu sein oder abzustürzen.

**Ablauf:**
1. `./scripts/service_control.sh stop`
2. `./scripts/health_check.sh`

**Erwartetes Ergebnis:** curl kann `http://localhost:8090` nicht erreichen; das Skript gibt eine Fehlermeldung aus, beendet sich mit Exit-Code `1` und hängt eine `FEHLER`-Zeile an `logs/healthcheck.log` an.

**Beobachtetes Ergebnis:** ✅ Bestanden. Bei gestopptem Container protokollierte der Health Check korrekt `2026-09-09 10:01:57 FEHLER` und lieferte Exit-Code `1`, statt einen unbehandelten Fehler auszulösen — dies bestätigt konkret die Entscheidung, in `health_check.sh` kein `set -e` zu verwenden, da ein fehlgeschlagener `curl`-Aufruf hier ein erwarteter Zustand ist, der trotzdem protokolliert werden muss, kein Abbruchgrund.

**Nachweis:** Terminalausgabe des fehlgeschlagenen Health Checks (siehe [`evidence/README.md`](../evidence/README.md) dazu, welche Terminal-Screenshots sicher aufgenommen werden konnten).

## Testfall 3 — Erstellung des Betriebsreports

**Ziel:** Prüfen, dass `report_generator.py` eine gemischte Historie aus `OK`- und `FEHLER`-Einträgen korrekt zu einem verständlichen Report zusammenfasst.

**Ablauf:**
1. `./scripts/service_control.sh start` (Dienst nach Testfall 2 wieder hochfahren)
2. `./scripts/health_check.sh` (neuen `OK`-Eintrag aufzeichnen)
3. `python3 scripts/report_generator.py`
4. `cat reports/betriebsreport.txt`

**Erwartetes Ergebnis:** Der Report zählt korrekt 2 `OK`-Einträge und 1 `FEHLER`-Eintrag aus dem angesammelten Log, erkennt `OK` als letzten bekannten Status und empfiehlt — wegen des früheren Fehlers trotz aktuellem Erfolg — den Verlauf zu prüfen, statt einfach "stabil" zu melden.

**Beobachtetes Ergebnis:** ✅ Bestanden. Der Dienst wurde neu gestartet und war wieder erreichbar (`2026-09-09 10:03:15 OK`), und der erzeugte Report entsprach exakt den erwarteten Zahlen und der erwarteten Empfehlung (siehe den echten Reportinhalt in [`health-checks-and-logging.md`](health-checks-and-logging.md)).

**Nachweis:** Terminalausgabe der Reporterstellung und der resultierende Inhalt von `betriebsreport.txt` (siehe [`evidence/README.md`](../evidence/README.md)).

## Zusammenfassung

| # | Testfall | Ergebnis |
|---|---|---|
| 1 | Normalbetrieb | ✅ Bestanden |
| 2 | Gestoppter Dienst / Fehlererkennung | ✅ Bestanden |
| 3 | Reporterstellung | ✅ Bestanden |

Alle drei Testfälle wurden gegen die in diesem Repository enthaltene `docker-compose.yml` ausgeführt, ohne dass die Skripte zwischen dem ursprünglichen Testlauf und dem Inhalt dieses Repositorys verändert wurden.
