In Zeiten digitaler Fotografie und Smartphones drucken wenige Leute die ich kenne noch aufgenommene Fotos aus und kleben diese in ein Album. Digital aufgenommene Fotos und Videos werden meist vom Speichermedium des Fotoapparats bzw. des Smartphones auf den Computer gezogen und dort abgelegt. Um auf lange Sicht nicht den Überblick über eine private Fotosammlung zu verlieren, bedarf es einer gewissen Ordnung.

Für die Verwaltung meiner Fotosammlung habe ich mich seit jeher gegen den Einsatz spezieller Fotosoftware entschieden. Es gibt durchaus gute Programme, die einen Benutzer bei der Verwaltung einer Fotosammlung unterstüzen können, aber einen negativen Punkt haben alle Fotoverwaltungsprogramme gemein: Sie machen abhängig. Google hat es erst letzes Jahr gezeigt und hat seinen [Fotodienst Picasa eingestellt](http://winfuture.de/news,91068.html). Die Nutzer der Software waren gezwungen sich nach Alternativen umzusehen.
# Eine gute Ordnerstruktur
Eine chronologische Ordnerstruktur ist eine Lösung, mit der man nicht an einzelne Programme gebunden ist. Bei mir hat sich die Gruppierung nach Jahr, Monat und Ereignis etabliert. Diese sieht folgendermaßen aus:
```
Bilder/
  2015/
  2016/
  2017/
    2017-01/
    2017-02/
      2017-02-13 Geburtstag/
    2017-03/
      2017-03-05 Urlaub/
      2017-03-07/
```
Diese Strukturierung ist extrem simpel aber dennoch nützlich.
# Dateibenennung
In vielen Systemen werden Inhalte eines Ordners standardmäßig nach Dateinamen sortiert aufgelistet. Liegen in einem Ordner Fotos, die von verschiedenen Kameras aufgenommen wurden, so haben diese oft unterschiedliche Bennenungsschemen und unterscheiden sich auch in der Laufnummer. Eine Sortierung nach Dateinamen entspricht folglich nicht mehr der chronologischen Abfolge der Aufnahmen. Die Fotos sind durcheinander gemischt, wie man an folgendem Beispiel erkennt:
```
10990832_10152595682692484_5628450190846343807_o.jpg
20170228001226.JPG
CA064BDD-479F-403B-B582-B97E06EB58E5.jpeg
IMG_6498.JPG
IMG_6507.JPG
```
Da das Erstellungsdatum eines Bildes nicht unbedingt mit dem tatsächlichen Aufnahmezeitpunkt übereinstimmen muss, ist auch eine Sortierung nach Erstellungsdatum nicht zwingend chronologisch.

Die beste Lösung ist meines Erachtens den Aufnahmezeitpunkt in den Dateinamen zu übernehmen. Die Dateinamen sollen Datum sowie Uhrzeit enthalten:
```
20170124_143108.jpg
20170124_143639.jpg
20170124_202956.m4v
```
# Umgang mit Metadaten
Was ist nun wenn der eigentliche Zeitstempel eines Bildes verloren geglaubt scheint? Nahezu alle modernen Kameras speichern Metadaten eines JPEG-Bildes in der Bilddatei selbst ab. Diese Metadaten sind vom Format Exif und können z. B. folgendes beinhalten:
* Kameramodell mit dem das Foto aufgenommen wurde 
* geografische Koordinaten 
* Aufnahmezeitpunkt

# ExifTool: Dein bester Freund
Ich habe das Anlegen der Ordnerstruktur für neue Bilder lange Zeit händisch gemacht. Da das sehr aufwändig ist, habe mich nach einer automatisierten Möglichkeit umgesehen. Dabei bin ich schnell über die beiden Tools __exiv2__ und __ExifTool__ gestolpert. Diese Kommandozeilenwerkzeuge können Metadaten auslesen und anhand dieser Informationen Dateien ordnen und umbenennen. Da der Funktionsumfang von ExifTool deutlich größer ist - und vor allem weil es auch Metadaten aus Videos auslesen kann - habe ich mich dazu entschieden meine Bilder mit Hilfe dieses Tools zu ordnen.

Das Programm lässt sich über die Webseite von [The Sudbury Neutrino Observatory](https://www.sno.phy.queensu.ca/~phil/exiftool) herunterladen. Nach der Installation kann das Programm über eine Kommandozeile genutzt werden.

Der Befehl, mit dem ich meine Bildersammlung ordne, ist der Folgende:
```
exiftool -v -r -d ./%Y/%Y-%m/%Y-%m-%d/%Y%m%d_%H%M%S%%+2c.%%e '-FileName&lt;CreateDate' *
```
Ich möchte den Befehl kurz zerlegen und erklären:
* __exiftool__ ist der Aufruf des Programmes, danach folgenden diverse Parameter: 
* __-v__ erzeugt eine Ausgabe mit mehr Informationen als üblich 
* __-r__ bedeutet, dass gefundene Ordner rekursiv nach Dateien durchsucht werden 
* -d ./%Y/%Y-%m/%Y-%m-%d/%Y%m%d_%H%M%S%%+2c.%%e spezifiziert wie die gewünschte Ordnerstruktur und Dateibenennung ist. Dabei steht
  * __.__ für das aktuelle Verzeichnis 
  * __%Y__ für Jahr, 
  * __%m__ für Monat, 
  * __%d__ für Tag, 
  * __%H__ für Stunde, 
  * __%M__ für Minute und 
  * __%S__ für Sekunde. 
  * __%+2c__ hängt an den Dateinamen eine zweistellige Laufnummer falls bereits eine Datei mit dem erzeugten Namen existiert 
  * __%e__ ist die Dateiendung der Originaldatei. 
 
* Mit __-FileName&lt;CreateDate__ wird angegeben, dass die Informationen zu Tag, Monat, Jahr aus dem Metadaten-Feld CreateDate genommen werden. 
* __*__ bedeutet, dass alle Dateien in dem aktuellen Verzeichnis prozessiert werden sollen. 
Dieses Vorgehen funktioniert nicht bei Bildern bei denen die Metadaten entfernt wurden (z. B. durch sog. Metadaten-Stripping). Beispielsweise werden beim Versenden von Bildern über WhatsApp die Metadatendaten entfernt.

Weiterhin kann das Tool natürlich nicht wissen, welches Ereignis an einem Tag stattgefunden hat. Die Ereignisbeschreibung muss also zusätzlich noch manuell angegeben werden.

Wenn ich also neue Bilder vom iPhone auf das Laptop ziehe, dann lege ich alle neuen Bilder in einen neuen Ordner und navigiere mit dem Terminal hinein. In dem Ordner wird der obige Befehl ausgeführt und erzeugt anschließen die gewünschte Strukturierung. Die erzeugten Ordner müssen jetzt nur noch an die Stelle kopiert werden, wo die bereits geordneten Bilder liegen.
