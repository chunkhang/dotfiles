' Run WSL as a daemon, to prevent it from shutting down
' Use with Windows Task Scheduler
' https://github.com/microsoft/WSL/issues/9667#issuecomment-2074976740
' https://serverfault.com/a/1172583

Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -Command ""wsl --cd ~""", 0, False
