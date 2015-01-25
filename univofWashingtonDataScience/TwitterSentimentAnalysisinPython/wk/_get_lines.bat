@echo off

REM ======================================================================
REM
REM NAME: 
REM
REM AUTHOR: Scott McKinney
REM DATE  : 
REM
REM PURPOSE: 
REM COMMENT: 
REM DEPENDENCIES:
REM
REM Revisions:
REM
REM ======================================================================

setlocal ENABLEEXTENSIONS
setlocal ENABLEDELAYEDEXPANSION

set a=%1
if "%1"=="" goto HELP
if "%a:~0,2%"=="/?" goto HELP
if "%a:~0,2%"=="-?" goto HELP
if "%a:~0,2%"=="/h" goto HELP
if "%a:~0,2%"=="/H" goto HELP
if "%a:~0,2%"=="-h" goto HELP
if "%a:~0,2%"=="-H" goto HELP
if "%a:~0,3%"=="--h" goto HELP
if "%a:~0,3%"=="--H" goto HELP

:: set counter
set c=0
for /f "delims=|" %%i in (%1) do (
:: increment counter for each line read
  set /a c=!c!+1
  if !c! leq %3 echo %%i >> %2
)
goto END

:HELP
echo.
echo Usage: %0 ^<input file^> ^<output file^> ^<n lines^>
echo.
echo. Outputs the first ^<n^> lines from ^<input file^> to ^<output file^>.
echo.
:END