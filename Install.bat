@echo off
setlocal enabledelayedexpansion
title GTA V Enhanced - Woo Pack Installer
cd /d "%~dp0"

echo ============================================================
echo   GTA V Enhanced - Woo Pack Installer
echo   Drag and drop install: just run this file.
echo ============================================================
echo.

rem ---- locate the game ----
set "GAME=%~1"
if defined GAME goto found
for %%R in (HKCU\SOFTWARE\Valve\Steam HKLM\SOFTWARE\WOW6432Node\Valve\Steam) do (
  for /f "tokens=2,*" %%A in ('reg query "%%R" /v SteamPath 2^>nul') do set "STEAM=%%B"
)
if defined STEAM if exist "%STEAM%\steamapps\common\Grand Theft Auto V Enhanced" set "GAME=%STEAM%\steamapps\common\Grand Theft Auto V Enhanced"
if not defined GAME for %%D in ("%ProgramFiles(x86)%\Steam\steamapps\common\Grand Theft Auto V Enhanced" "%ProgramFiles%\Steam\steamapps\common\Grand Theft Auto V Enhanced" "D:\Steam\steamapps\common\Grand Theft Auto V Enhanced" "E:\Steam\steamapps\common\Grand Theft Auto V Enhanced") do if exist "%%~D" set "GAME=%%~D"
:found
if not defined GAME (
  echo Could not find the game automatically.
  set /p "GAME=Drag the game folder here and press Enter: "
)
if not exist "%GAME%\GTA5_Enhanced.exe" (
  echo ERROR: "%GAME%" does not contain GTA5_Enhanced.exe
  pause
  exit /b 1
)
echo Game folder : "%GAME%"
echo.

rem ---- extract the pack volumes if needed ----
set "SZ="
for %%Z in ("%ProgramFiles%\7-Zip\7z.exe" "%ProgramFiles(x86)%\7-Zip\7z.exe") do if exist "%%~Z" set "SZ=%%~Z"
if not defined SZ for /f "delims=" %%Z in ('where 7z 2^>nul') do set "SZ=%%Z"
if exist "%~dp0WooPack-Core\onigiri" goto extracted
if not defined SZ (
  echo ERROR: 7-Zip not found. Install 7-Zip, then re-run.
  echo Download: https://www.7-zip.org/
  pause
  exit /b 1
)
echo Extracting WooPack-Core.7z.001 ... (this takes a minute)
"%SZ%" x "%~dp0WooPack-Core.7z.001" -o"%~dp0" -y >nul
if errorlevel 1 (
  echo ERROR: extraction failed. Make sure BOTH volume files are in this folder.
  pause
  exit /b 1
)
:extracted
for /d %%D in ("%~dp0*Woo Pack*") do set "SRC=%%~D"
if not defined SRC set "SRC=%~dp0"
echo Pack folder  : "%SRC%"
echo.

rem ---- copy into the game (merge, never deletes game files) ----
echo Copying mods into the game folder ...
robocopy "%SRC%" "%GAME%" /E /IS /NFL /NDL /NJH /R:1 /W:1
echo.
echo ============================================================
echo   Done! Next steps:
echo   1. Install ScriptHookV (Enhanced build) if you don't have
echo      it yet:  https://www.dev-c.com/gta/scripthookv
echo   2. Optional: NVE (NaturalVision Evolved) is NOT included
echo      - buy it from Razed's Patreon if you want it.
echo   3. Launch the game once. Check ScriptHookVDotNet.log in
echo      the game folder for any errors.
echo ============================================================
pause
