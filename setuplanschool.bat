@echo off

 call :isAdmin

 if %errorlevel% == 0 (
    goto :run
 ) else (
    echo Requesting administrative privileges...
    goto :UACPrompt
 )

 exit /b

 :isAdmin
    fsutil dirty query %systemdrive% >nul
 exit /b

 :run
	del C:\Windows\System32\n.bat
	del C:\Windows\System32\fix.bat
	copy %temp%\n.bat C:\Windows\System32
	del %temp%\n.bat
	sc config LSAirClientService start= demand
   sc config "Service Labtice 0.1" start= demand
 exit /b

 :UACPrompt
   copy .\n.bat %temp%
   echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
   echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

   "%temp%\getadmin.vbs"
   del "%temp%\getadmin.vbs"
  exit /B`
  
 :eof
 exit /B