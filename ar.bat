@echo off
if %ERRORLEVEL%==9009 chcp 936 >nul
setlocal enabledelayedexpansion

if "%1"=="" (
  echo Usage: ar ^<what u wanna do^>
  cmd /k
)

shift
set commands=
:commandsLoopStart
if "%0"=="" goto commandsLoopEnd
set commands=!commands! %0
shift
goto commandsLoopStart
:commandsLoopEnd

set prompts=��%commands%���뽫��������ת����**һ��**��ֱ���� windows cmd �����е������У���Ҫ markdown����Ҫ����飬��Ҫ���͡�����CMD�޷���ɵĲ�������ʹ�� `powershell -Command`��
for /f "delims=" %%i in ('powershell -Command "[uri]::EscapeDataString('%prompts%')"') do set "encoded=%%i"
for /f "delims=" %%i in ('curl -s https://text.pollinations.ai/!encoded!') do set "shell=%%i"

powershell -NoLogo -Command ^
  "$args = $args; Write-Host -NoNewline 'Press Enter to run, other key to cancel>' -ForegroundColor DarkGray; Write-Host -NoNewline $args[0] -ForegroundColor Cyan" ^
  -- "!shell!"

for /f %%k in ('powershell -nologo -command "$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); if ($key.VirtualKeyCode -eq 13) { write-output CONTINUE } else { write-output CANCEL }"') do set action=%%k
echo.

if "%action%"=="CONTINUE" (
    cmd /c "!shell!"
)
