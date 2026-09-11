# Nachweise

Dieser Ordner enthält eine auf Privatsphäre geprüfte Auswahl der Screenshots, die während der echten Testläufe entstanden sind (siehe [`../docs/testing.md`](../docs/testing.md)).

## Enthalten

| Datei | Testfall | Was zu sehen ist |
|---|---|---|
| `screenshots/01-portal-running.png` | Testfall 1 (Normalbetrieb) | Das im Browser unter `http://localhost:8090` geladene Portal — bestätigt, dass der Nginx-Container den erwarteten Inhalt ausliefert. Die persönliche Browser-Lesezeichenleiste wurde aus diesem Bild herausgeschnitten; der eigentliche Portalinhalt ist unverändert und in Originalauflösung zu sehen. |

## Nicht enthalten (geprüft, aber bewusst ausgeschlossen)

Während der Tests wurden drei weitere Terminal-Screenshots aufgenommen (zu den Testfällen 1–3: Normalbetrieb, Fehlerfall gestoppter Dienst, Reporterstellung). Jeder wurde einzeln daraufhin geprüft, ob personenbezogene Angaben allein durch Zuschneiden sicher entfernt werden können.

Bei allen drei beginnt jede Befehlszeile im Terminal mit einem Shell-Prompt der Form `<Benutzername>@<Hostname>:<persönlicher Dateipfad>$`, das sich über praktisch jede Zeile vom oberen bis zum unteren Bildrand wiederholt. Da die identifizierenden Angaben direkt in denselben Zeilen wie die eigentliche Befehlsausgabe stehen — nicht in einem abgetrennten Kopf- oder Fußbereich — lassen sie sich nicht durch Zuschneiden entfernen, ohne auch den technischen Nachweis zu beschädigen, den die Screenshots eigentlich belegen sollen.

Gemäß der Nachweis-Richtlinie dieses Projekts wird Terminaltext niemals bearbeitet, neu getippt oder verändert, um persönliche Angaben zu entfernen — es wird ausschließlich einfaches Zuschneiden verwendet, und auch das nur, wenn dadurch der Nachweis nicht beeinträchtigt wird. Da ein ehrliches Zuschneiden bei diesen drei Bildern nicht möglich war, wurden sie aus diesem öffentlichen Repository ausgeschlossen, statt sie zu verändern. Sie bleiben im ursprünglichen (nicht öffentlichen) Projektbereich verfügbar, falls jemand die vollständigen Testnachweise inklusive der persönlichen Umgebungsdetails einsehen möchte.

**Es ist besser, weniger, aber unverfälschte Screenshots zu veröffentlichen als bearbeitete Nachweise.**

## Anzahl der Screenshots

- Bei den Tests aufgenommen: 4
- In diesem öffentlichen Repository enthalten: 1
- Ausgeschlossen (persönliche Terminal-Identität konnte nicht sicher herausgeschnitten werden): 3
