@echo off

set AUTOHAUS=false
IF %1.==. GOTO No1
IF %2.==. GOTO No2
IF NOT [%3]==[] set AUTOHAUS=true
set OLDDIR=%CD%
set TEMPLATE=%CD%

:prepare
cd %1

set BILD=DSC_0001.jpg
set ZIEL_BILD=%BILD%
IF NOT [%4]==[] set ZIEL_BILD=%4

ECHO Bearbeite Bild %1\%BILD% und speichere als %ZIEL_BILD%

set LOGO=%TEMPLATE%\%2.png
ECHO Nutze Logo-Vorlage: %LOGO% 


for /f  %%i in ('identify -format "%%w" %BILD% ') do  set WIDTH=%%i
ECHO Breite des Bildes %BILD%: %WIDTH%px

echo Skaliere das Logo auf %WIDTH%px
convert %LOGO% -resize %WIDTH% sizelogo.png

echo Benutze zweites Logo: %AUTOHAUS%
IF %AUTOHAUS%==true (
	 set LOGO2=%TEMPLATE%\%3.png
	 ECHO Nutze Logo-Vorlage: %LOGO2% 
	 convert %LOGO2% -resize %WIDTH% sizelogo2.png
) 

:conv
 IF %AUTOHAUS%==false ( 
	convert -verbose %BILD% -page +0+0 sizelogo.png -flatten %ZIEL_BILD%
	del sizelogo.png
 ) ELSE ( 
	convert -verbose %BILD% -page +0+0 sizelogo.png -page +0+0 sizelogo2.png  -flatten %ZIEL_BILD%
	del sizelogo2.png
 )  
GOTO end

:No1
  ECHO Kein Ordner mit den Bildern angegeben
  ECHO Beispiel: logo C:\bilder_ordner vw autohaus
  ECHO Nutzt die Logos vw.jpg und autohaus.jpg im aktuellen Verzeichnis
GOTO end
:No2
  ECHO Keine Logo-Vorlage angegeben
GOTO end
:end
cd %OLDDIR%
 echo Konvertierung abgeschlossen.
