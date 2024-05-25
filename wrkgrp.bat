@echo off
color 0A
setlocal enabledelayedexpansion
if "%1" neq "" ( goto %1)

rem cd C:\Workgroup

:boot
cls
echo Computing Disk Processor Operating System is powering on...
echo please wait...
echo.
echo 888b     d888      .d8888b.      88888888888 
echo 8888b   d8888     d88P  Y88b     88888888888 
echo 88888b.d88888     Y88b.              888     
echo 888Y88888P888      "Y888b.           888  
echo 888 Y888P 888         "Y88b.         888     
echo 888  Y8P  888           "888         888  
echo 888   "   888     Y88b  d88P         888     
echo 888       888      "Y8888P"          888     
echo.
echo CDP-OS(TM) for Workgroups 1.31
echo (C) Copyright Millennium Software Technologies (TM) 2023, 2024
echo.
echo MST U.S. Development Team (TM)
echo.
echo [Press any key to boot.]
echo.
pause >nul

:TelnetNetwork
rem Establish connection to MST Telnet Servers
:Telnet_Connection
echo Connecting To Nova Robotics Online Services...
set "ServerAddress=77.111.247.57"
set SERVERPORT=Port 2017
Set altport=2017
Set BackupPort=23
ping -n 1 !ServerAddress! >nul
:: Check if the IP address is valid
ping -n 1 !ServerAddress! >nul
if !errorlevel! neq 0 (
    color 0C
    echo Error 503: Nova Online Services are likely offline
    echo Please Try Again Later and/or check your connection
    color 0A
    echo Proceeding with Offline Mode...
    timeout /t 7 >nul
    goto logon
)
:Main_Telnet_Connection
cls 
echo Attempting to connect to CT2017...
telnet -e 2017 77.111.247.57
:: Check the connection status for the primary port
if errorlevel 1 (
    echo Primary port connection failed. Attempting to connect to the backup port...
    echo Connecting to CT0023...
telnet -e 23 2001:67c:2660:425:3617:ebff:fee4:6b47
  :: Check the connection status for the backup port
    if errorlevel 1 (
color 0C
        echo Both primary and backup ports are down...
        echo Check your connection and/or try again later.
pause >nul
goto logon






:: Ensure the main directory exists
if not exist C:\CDP\Users md C:\CDP\Users

:logon
cls
echo =======================
echo [Log on to CDP-OS 1.31]
echo =======================
echo [1] List User Accounts
echo [2] Sign In
echo [3] Add Account
echo [4] Remove Account
echo [5] Exit
echo =======================
set /p choice=Enter your choice (1-5):

if "%choice%"=="1" goto list_users
if "%choice%"=="2" goto sign_in
if "%choice%"=="3" goto add_account
if "%choice%"=="4" goto remove_account
if "%choice%"=="5" goto exit
goto logon

:list_users
cls
if not exist C:\CDP\Users\usernames.txt (
    echo No users available.
) else (
    type C:\CDP\Users\usernames.txt
)
pause
goto logon

:sign_in
cls
set /p username=Enter username:
set /p password=Enter password:

if exist C:\CDP\Users\%username%\password.txt (
    set /p stored_password=<C:\CDP\Users\%username%\password.txt

    if "%password%"=="%stored_password%" (
        echo Welcome, %username%!
        goto main
    ) else (
        echo Invalid username or password.
    )
) else (
    echo Invalid username or password.
)
set /p guest=Proceed under Guest Account? {Y/N}:
if /I "%guest%"=="Y" goto guest
goto logon

:add_account
cls
set /p username=Enter new username:
set /p password=Enter new password:

if exist C:\CDP\Users\%username% (
    echo User already exists.
) else (
    md C:\CDP\Users\%username%
    echo %password%>C:\CDP\Users\%username%\password.txt
    echo %username%>>C:\CDP\Users\usernames.txt
    echo User account created successfully.
)
pause
goto logon

:remove_account
cls
set /p username=Enter username to remove:
set /p password=Enter password for verification:

if exist C:\CDP\Users\%username%\password.txt (
    set /p stored_password=<C:\CDP\Users\%username%\password.txt

    if "%password%"=="%stored_password%" (
        echo y | rd /s C:\CDP\Users\%username%
        findstr /v "%username%" C:\CDP\Users\usernames.txt > C:\CDP\Users\temp_usernames.txt
        copy /y C:\CDP\Users\temp_usernames.txt C:\CDP\Users\usernames.txt
        del C:\CDP\Users\temp_usernames.txt
        echo User account removed successfully.
    ) else (
        echo Invalid username or password.
    )
) else (
    echo Invalid username or password.
)
pause
goto logon

:guest
cls
echo Guest Account
echo =============
echo Setting up new temporary account...
echo.
echo [No data will be saved - Backup data before logging off]
md C:\CDP\Users\temp
set username=Guest
goto main



:Main
cls
rem wrkgrp.bat = workgroup.bat
echo CDP-OS (TM) for Workgroups 1.31 Experimental (CDP-OS (TM) for Workgroups 1.3 EXP) 
echo (C) Copyright MST (TM) 2023, 2024
echo Version: OS Version 1.3.1.0
echo.
echo CDP-OS for Workgroups 3.11
echo.
echo Welcome, %username%
echo ==================================================
echo.
echo [1] [Desktop]
echo [2] [Settings]
echo [3] [Extras]
echo [4] [Nova Express] {LAN}
echo [5] [Online Services]
echo [6] [Pip-Assistant (1/2)]
echo [7] [Power Off]
echo [8] [Exit to DOS Mode]
echo.
echo ==================================================
set /p answer=3.11//
if %answer%==1 goto Desktop
if %answer%==2 goto Settings
if %answer%==3 goto Extras
if %answer%==4 goto LAN
if %answer%==5 goto Online
if %answer%==6 goto pipassist
if %answer%==7 goto exit

echo Error: Item requested not found
echo please choose a valid input
goto Main

:Desktop
cls
echo CDP-OS [Version 1.3.1.0]
ECHO (C) Millennium Software Technologies
echo.
echo %date% / %time
echo.
echo Welcome to CDP-OS for Workgroups 1.31, %username%
echo =================================================================
echo.
echo [1] User Guide                     [6] Calculator
echo [2] Nova Online Services           [7] Return to Main Interface
echo [3] Nova Application Launcher      [8] Settings
echo [4] My Journal                     [9] Note to User
echo [5] File Archive                   [10] Terminal
echo [6] Nova Express                   [11] Pip Assistant
echo.
echo ================================================================
Set /p answer=Desktop//:

If %answer%==1 goto Guide
If %answer%==2 goto Online_Services
If %answer%==3 goto AppStore
If %answer%==4 goto TextEditor
If %answer%==5 goto Files
If %answer%==6 goto Network
If %answer%==7 goto Main
If %answer%==8 goto Settings
If %answer%==9 goto Note
If %answer%==10 goto Terminal
If %answer%==11 goto Pipassist


echo Error: Application not found in this workgroup/PC.
echo [Check for typos, or, ask your system administrator]
echo.
echo [More Details:]
echo.
echo Error 0x000487
echo FILE_NOT_FOUND
pause >nul
goto :Desktop


:Settings
cls
Echo CTL Launching "Settings"
rem CTL means "Central Terminal Launch"
Echo running....
echo ----------------------------
Echo Settings:
Echo ============================
echo [1] [Your System Information]
echo [2] [CDP-OS Information]
echo [3] [Wi-Fi Options]
echo [4] [Network]
echo [5] [Return to Main Screen]
Echo ============================
set /p "answer=Settings//:
if %answer%==1 goto System_Info
if %answer%==2 goto CDP_Info
if %answer%==3 goto Wi_Fi
if %answer%==4 goto Network
if %answer%==5 goto Main

echo Item not found in settings list.
goto Settings

:Wi_Fi
cls
echo Not implemented
goto Settings

:System_Info
cls
echo Displaying System_Info...

:: Use systeminfo command to retrieve system information and display it
systeminfo
if %errorlevel% neq 5 goto doscompat_set

:doscompact_set
cls
::for MS-DOS based version of CDP-OS - has no systeminfo command
echo USER: %username%
echo OS NAME: CDP-OS
echo CDP-OS MK. I
echo        CDP-OS FOR WORKGROUPS 1.31
echo CDP-DOS VERSION 1.31
mem
chkdsk
echo.
echo Press any key to return...
pause >nul
goto settings



:CDP_Info
cls
echo Computing Disk Processor Information:
echo =======================================
echo Created by: Millennium Software Technologies
echo Kernel: Central Disk Processor Disk Operating System [1.31]
echo This Version: CDP-OS for DOS-Based Environments
echo Current Version: 1.3.1.0
echo Current OS Version: 1.3.1.0 Developer Preview
echo CDP-OS for Workgroups 1.31 [OEM]
echo =======================================
echo.
echo Press any key to return...
pause >nul
goto Settings


:Network
cls
ping Google.com >nul
echo Scanning Your Network...
timeout /t 7 >nul
Echo ======================================

:: Display available Wi-Fi networks
netsh wlan show networks

arp -a
Netstat
getmac
Ipconfig /all

:: Check the connection status
netsh wlan show interfaces

echo Press any key to return...
pause >nul
goto Settings



::Terminal Begin

:Terminal
cls
echo 888b     d888      .d8888b.      88888888888 
echo 8888b   d8888     d88P  Y88b     88888888888 
echo 88888b.d88888     Y88b.              888     
echo 888Y88888P888      "Y888b.           888  
echo 888 Y888P 888         "Y88b.         888     
echo 888  Y8P  888           "888         888  
echo 888   "   888     Y88b  d88P         888     
echo 888       888      "Y8888P"          888     
echo.
echo.
echo.
:command
echo [%Date%] [%Time%]
echo [CDP-DOS VERSION 1.31]
echo.
echo Current Directory: {%cd%}

:commandprompt
set /p command="%cd%> "
if /I "%command%" == "VER" goto version
if /I "%command%" == "CMD" goto cmd-warn
if /I "%command%" == "COMMAND" goto command
if /I "%command%" == "HELP" goto cmd-help
if /I "%command%" == "EXIT" goto Main
if /I "%command%" == "REBOOT" goto REBOOT
%command%
if %errorlevel% neq 0 goto Command_Error

:Command_Error
echo.
echo ERROR 0x092360AE - INVALID USER RESPONSE
echo INVALID COMMAND, FILE, OR PROGRAM
echo.
goto commandprompt

:version
echo COMPUTING DISK PROCESSOR - VERSION [1.3.1.0]
echo CDP-DOS (C) MST LLC. (TM)
goto commandprompt

:cmd-warn
echo WARNING: THIS WILL CHANGE INTERPRETER TO 'CMD' (*Command Prompt*)
echo THIS WILL ONLY WORK ON WINDOWS OS'
echo PROCEED? (Y/N)
set /p confirm="CMD> "
if /I "%confirm%" == "Y" goto cmd
if /I "%confirm%" == "N" goto commandprompt

:REBOOT
cls
echo          REBOOT IN PROCESS...
echo **ALL UNSAVED WORK WILL BE DELETED!**
echo.
echo [PLEASE WAIT...]
endlocal
verify OFF
echo [COMPLETE - AUTO-RESTART IN 15 SECONDS OR PRESS ANY KEY TO REBOOT NOW]
timeout /t 15 >nul
goto BOOT

::Terminal End


verify OFF
verify ON
goto Main
:: Reset Verify
rem In case a error directs the script to end, this will catch it and recover and redirect the script to the main screen

:Exit
echo Powering Off Your Computer...
echo Thank you for choosing MST
echo (C) Millennium Software Technologies
Echo ====================================
echo Goodbye, %Username%
color 0C
echo Warning! System Shutdown Imminent!
shutdown /s /f /t 10
endlocal
exit /b
color 0A

