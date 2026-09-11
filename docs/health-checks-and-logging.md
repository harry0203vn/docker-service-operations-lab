# Health Checks und Logging

## `scripts/health_check.sh`

Prüft, ob das Portal unter `http://localhost:8090` erreichbar ist, und protokolliert das Ergebnis.

Ablauf:

1. Sendet eine HTTP-Anfrage mit `curl -fsS -o /dev/null -w "%{http_code}" --max-time 5 http://localhost:8090`.
2. Gelingt curl **und** liefert die Antwort exakt den HTTP-Status `200`, gilt der Check als erfolgreich.
3. Andernfalls (Verbindung abgelehnt, Timeout nach 5 Sekunden oder ein anderer Statuscode) gilt der Check als fehlgeschlagen.
4. In beiden Fällen wird eine Zeile mit Zeitstempel an `logs/healthcheck.log` angehängt:
   - `YYYY-MM-DD HH:MM:SS OK` bei Erfolg
   - `YYYY-MM-DD HH:MM:SS FEHLER` bei Fehler
5. Zusätzlich gibt das Skript eine kurze, verständliche Meldung im Terminal aus und beendet sich mit Exit-Code `0` (Erfolg) bzw. `1` (Fehler), sodass es in Automatisierung (z. B. einem Cronjob oder CI-Schritt) verwendet werden kann, die auf den Exit-Code reagiert.

Das Skript verwendet bewusst **kein** `set -e`, da ein fehlgeschlagener `curl`-Aufruf (Dienst nicht erreichbar) hier ein erwartetes, kontrolliert zu behandelndes Ergebnis ist — kein Skriptfehler, der zum Abbruch führen sollte, bevor die Logzeile geschrieben wurde.

### Reales Log-Beispiel

Ein echter Testlauf des Projekts erzeugte folgendes `logs/healthcheck.log` (Testfall 1 → Testfall 2 → Testfall 3, siehe [`testing.md`](testing.md)):

```
2026-09-09 09:59:02 OK
2026-09-09 10:01:57 FEHLER
2026-09-09 10:03:15 OK
```

Das zeigt: Der Dienst war erreichbar, wurde dann kurz gestoppt (korrekt als `FEHLER` protokolliert) und war nach dem Neustart wieder erreichbar.

## `scripts/report_generator.py`

Liest `logs/healthcheck.log` zeilenweise ein und erzeugt daraus `reports/betriebsreport.txt`.

Ablauf:

1. Existiert die Logdatei noch nicht, gibt das Skript einen hilfreichen Hinweis aus ("zuerst `health_check.sh` mindestens einmal ausführen") und beendet sich mit Exit-Code `1`, statt abzustürzen.
2. Jede nicht-leere Zeile wird anhand ihres letzten Worts eingeordnet: Zeilen, die auf `OK` enden, erhöhen den OK-Zähler, Zeilen, die auf `FEHLER` enden, den Fehlerzähler; nicht erkannte Zeilen werden einfach übersprungen, damit eine einzelne fehlerhafte Zeile den Report nicht zum Absturz bringt.
3. Die **letzte** ausgewertete Zeile bestimmt den "letzten bekannten Status".
4. Aus letztem Status und Fehleranzahl wird eine kurze Empfehlung abgeleitet:
   - Keine auswertbaren Einträge vorhanden → *"Keine auswertbaren Einträge vorhanden – Healthcheck prüfen."*
   - Letzter Status `OK` und nie ein Fehler → *"Dienst läuft stabil."*
   - Letzter Status `OK`, aber mindestens ein früherer `FEHLER` → *"Dienst läuft aktuell, es gab jedoch frühere Fehler – Verlauf prüfen."*
   - Letzter Status `FEHLER` → *"Dienst prüfen."*
5. Das Ergebnis wird in `reports/betriebsreport.txt` geschrieben.

### Reales Report-Beispiel

Erzeugt aus dem obigen Log-Beispiel:

```
Projekt: Nordstern Webportal (Projekt 5 - Docker Service Betrieb)
Report erzeugt am: 2026-09-09 10:03:19

Anzahl erfolgreicher Healthchecks (OK): 2
Anzahl fehlgeschlagener Healthchecks (FEHLER): 1
Letzter bekannter Status: OK

Empfehlung: Dienst laeuft aktuell, es gab jedoch fruehere Fehler - Verlauf pruefen.
```

Der Reportinhalt wird vom Skript selbst auf Deutsch erzeugt, passend zur Sprache der ursprünglichen Aufgabenstellung; die oben beschriebene Zähl- und Empfehlungslogik entspricht genau diesem Beispiel — hier führt "1 früherer Fehler, letzter Status OK" korrekt zur Empfehlung "läuft aktuell, aber Verlauf prüfen".
