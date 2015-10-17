@echo off

set AUTOHAUS = "false"
IF %1.==. GOTO No1
IF %2.==. GOTO No2
IF %3.==. set AUTOHAUS="true"
set OLDDIR=%CD%
set TEMPLATE=%CD%

:conv
cd %1
set LOGO=%TEMPLATE%\%2.jpg
IF %AUTOHAUS% == "false" (
	 set LOGO2=%TEMPLATE%\%3.jpg
	 ECHO Nutze Logo-Vorlage: %LOGO2% 
	 ) 

ECHO Nutze Logo-Vorlage: %LOGO% 

 ECHO Bearbeite Bild %%p
 IF %AUTOHAUS% == "false" ( 
	convert -verbose %%p -page %LOGO% -flatten %%p
 ) ELSE ( 
    set LOGO2=%TEMPLATE%\%3.jpg
	convert -verbose %%p -page %LOGO% -page %LOGO2%  -flatten %%p
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
:No3
  ECHO Kein Autohaus angegeben
 GOTO end
:end
cd %OLDDIR%
 echo Konvertierung abgeschlossen.
