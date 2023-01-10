# m335 Dominik Dierberger

## Anforderungen
| Nummer | Beschreibung                                                            |
|--------|-------------------------------------------------------------------------|
| 1      | Der Benutzer kann ein Konto erstellen                                   |
| 2      | Der Benutzer kann sich anmelden                                         |
| 3      | Der Benutzer kann Bilder seiner Prüfungen hochladen                     |
| 4      | Der Benutzer kann Fächer erstellen                                      |
| 5      | Der Benutzer kann Noten eintragen                                       |
| 6      | Der Benutzer kann alle Fächer und deren Noten anschauen                 |
| 7      | Der Benutzer kann die Hochgeladenen Prüfungen in der Gallerie anschauen |
## UseCase

![](/assets/Documentation/UseCase.png)
## Storyboard
![](/assets/Documentation/Storyboard.jpg)
## Navigation
Mittels gut einsehbaren Knöpfen und Tooltips kann der Benutzer die Applikation benutzen und durch die verscheidenen Screens navigieren.
## Bildschirmformate
Flutter passt die Applikation automatisch an alle Bildschirm formate an.
## Usabilitykonzepte
| Konzept             | Umsetzung                                                                                                    |
|---------------------|--------------------------------------------------------------------------------------------------------------|
| Ladegeschwindigkeit | Die app lädt schnell und die Prozesse brauchen geringe Ladezeiten.                                           |
| Einfachheit         | Da die App nur geringe Funktionalität aufweisst, ist diese für den Benutzer einfach zu verstehen.            |
| Übersicht           | Die App beinhaltet nur das wichtigste wodurch eine gute Übersicht vorliegt.                                  |
| Navigation          | Die Naviagtion ist simpel und der Benutzer kann schnell durch die Verschiedenen seiten navigieren.           |
| Stabilität          | Die App läuft auf dem Gerät des Benutzers nativ mit der hohen verfügbarkeit von Firebase läuft diese Stabil. |
| Design              | Alle Seiten der App beinhalten ein simples und überall gleiches Design.                                      |

## Aufbau und Struktur
Auf der Startseite kann der Benutzer sich anmelden oder einen neuen Account erstellen. Nach einer efolgreichen Anmeldung wird der Benutzer weitergeleitet und kann Semster erstellen oder auf Semster zugreifen. In einem Semster sieht der Benutzer seine Fächer und innerhalb diesen Seine Noten welche er beide jeweils selber erstellen kann.

# Systemdokumentation

## Kurzanleitung für benutzer
1. Benutzer erstellen / Mit Benutzer anmelden.
2. Auf dem Exam Screen auf das Plus drücken.
3. Kursname und Note eintragen und auf Kurs erstellen drücken.
4. Auf der Homepage auf den Plus Knopf und ein Bild hochladen.
5. In der Gallerie hochgeladene Prüfungen anschauen.
6. Mittels Logout Button abmelden.
## Persistenzlösung
Die vom Nutzer erstellten Daten werden auf Firebase in einer Datenbank gespeichert.

## Sensoren in Applikation
Der Nutzer kann mittels des Kamera Buttons Bilder von seinen Prüfungen speichern und diese in der Gallerie anschauen.

## Netzwerkfuktionalität
Damit die Applikation Daten in der Datenbank speichern kann, ist eine Internetverbindung vorausgesetzt.
Ebenfalls wird für die Authentifizierung eine Internetverbindung vorausgesetzt.

# Testdokumentation

## Testfälle
| Testfall Nr. | Anf. Nr. | Voraussetzung                                                                                 | Eingabe                                                                        | Ausgabe                                |
|--------------|----------|-----------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|----------------------------------------|
| 1            | 1        | Die Applikation ist gestartet und der Benutzer hat auf den "Account erstellen knopf gedrückt" | Email und Password des Benutzer eingeben                                       | Weiterleitung auf die Startseite       |
| 2            | 2        | Die Applikation ist gestartet                                                                 | Email und Password des Benutzer eingeben                                       | Der Benutzer kommt auf die User Seite  |
| 3            | 3        | Der Benutzer ist angemeldet                                                                   | Auf den "Bilder Hochladen" knopf drücken und ein Bild hochladen                | Keine                                  |
| 4            | 4        | Der Benutzer ist angemeldet und auf dem exam screen                                           | Der Benutzer drück auf das Plus und gibt den Namen des Faches                  | Keine                                  |
| 5            | 5        | Der Benutzer ist angemeldet und auf dem exam screen                                           | Der Benutzer drück auf das Plus gibt die Note ein und drückt auf create course | Keine                                  |
| 6            | 6        | Der Benutzer ist angemeldet und auf dem exam screen                                           | Keine                                                                          | Alle Kurse und Noten werden angezeigt. |
| 7            | 7        | Der Benutzer ist in angemeldet und in der Gallerie                                            | Keine                                                                          | Alle Bilder werden angezeigt.          |

## Testprotokoll

| Test Nr. | Testfall Nr. | Datum    | Tester             | OK / NOK | Bemerkung                 |
|----------|:-------------|----------|--------------------|----------|---------------------------|
| 1        | 1            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
| 2        | 2            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
| 3        | 3            | 3.1.2023 | Dominik Dierberger | OK       | Im Emulator nicht testbar |
| 4        | 4            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
| 5        | 5            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
| 6        | 6            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
| 7        | 7            | 3.1.2023 | Dominik Dierberger | OK       | -                         |
