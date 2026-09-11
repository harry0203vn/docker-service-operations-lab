# Fehlerbehebung / Erkenntnisse

Reale Probleme, die beim Aufbau und Betrieb dieses Projekts aufgetreten sind, und wie sie gelöst wurden.

## 1. Keine offiziellen Webinhalte für das Portal verfügbar

**Problem:** Die ursprüngliche Aufgabenstellung beschrieb ein fiktives Unternehmen ("Nordstern Services GmbH") und verwies auf "bereitgestellte Webdateien" als Beispielinhalt für das Portal — ein solches Dateipaket existierte jedoch nirgendwo in den Kursunterlagen. Eine gründliche Suche im gesamten Kursordner (nach Dateinamen und Inhalten, u. a. nach "webportal", "Nordstern" und allgemein nach `*.html`/`*.css`/`*.js`-Dateien) ergab keinen zu Projekt 5 passenden Treffer. Die einzige HTML-Datei im gesamten Kursordner war eine nicht zusammenhängende Nginx-Übungsdatei aus einer früheren, anderen Aufgabe und passte inhaltlich nicht zu diesem Projekt.

**Lösung:** Es wurde eine kleine, selbst erstellte Platzhalter-Website (`webportal/index.html`, `webportal/style.css`) angelegt, passend zu dem in der Aufgabenstellung beschriebenen fiktiven Unternehmen. Sie enthält keine echten personenbezogenen oder organisatorischen Daten und ist klar erkennbar als Ersatz für den Inhalt, den eine echte Bereitstellung liefern würde.

**Erkenntnis:** Wenn eine Aufgabenstellung auf "bereitgestellte" Materialien verweist, die sich als nicht vorhanden herausstellen, sollte die durchgeführte Suche dokumentiert und ein klar gekennzeichneter Platzhalter erstellt werden, statt auf fachfremden Inhalt auszuweichen oder den Dienst gar nicht lauffähig zu machen.

## 2. Ein fehlgeschlagener `curl`-Aufruf muss als gültiges Ergebnis behandelt werden, nicht als Skriptfehler

**Problem:** Eine frühe Version der Health-Check-Logik hätte bei nicht erreichbarem Portal komplett abbrechen können (durch `set -e`), was verhindert hätte, dass der Fehler überhaupt protokolliert wird — genau der Fall, den der Health Check eigentlich erkennen soll.

**Lösung:** `health_check.sh` verzichtet bewusst auf `set -e` und prüft stattdessen den Exit-Status von curl sowie den zurückgegebenen HTTP-Code explizit, sodass ein nicht erreichbarer Dienst als normaler, protokollierter `FEHLER`-Eintrag mit Exit-Code `1` erfasst wird, statt das Skript abstürzen zu lassen.

**Erkenntnis:** Speziell bei einem Health-Check-Skript muss "die geprüfte Sache ist fehlgeschlagen" ein regulärer, behandelter Codepfad sein — keine Ausnahme, die das Skript beendet, bevor der Fehler überhaupt protokolliert wurde.

## 3. Fehlende Logdatei beim ersten Aufruf des Report-Generators

**Problem:** Würde `report_generator.py` ausgeführt, bevor `health_check.sh` jemals gelaufen ist, hätte das Skript andernfalls mit einem unbehandelten Datei-nicht-gefunden-Fehler abgebrochen.

**Lösung:** Das Skript prüft explizit, ob `logs/healthcheck.log` existiert, bevor es versucht, die Datei zu lesen. Ist das nicht der Fall, gibt es einen klaren Hinweis aus, zuerst `health_check.sh` auszuführen, und beendet sich sauber mit Exit-Code `1` statt mit einem rohen Traceback.

**Erkenntnis:** Skripte, die von einem vorherigen Skriptlauf abhängen, sollten diese Voraussetzung selbst erkennen und erklären, statt einen generischen Laufzeitfehler anzuzeigen.
