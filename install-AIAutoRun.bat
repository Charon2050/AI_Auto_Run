@echo off

echo %path% | findstr %cd%; >nul && (
    echo You have already installed AIAutoRun! Just run `ar ^<what u wanna do^>`.
    pause
) || (
    echo installing AIAutoRun ...
    powershell -Command "[Environment]::SetEnvironmentVariable('Path', \"$PWD;\" + [Environment]::GetEnvironmentVariable('Path','User'), 'User')"
    echo AIAutoRun install completed! Just run `ar ^<what u wanna do^>`.
    pause
)

