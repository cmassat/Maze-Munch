
..\..\..\Repos\.venv\Scripts\activate
Remove-Item *.pgz -Verbose  -ErrorAction Ignore
Remove-Item *.txt -Verbose  -ErrorAction Ignore
Remove-Item *.map -Verbose  -ErrorAction Ignore
Remove-Item *.lst -Verbose  -ErrorAction Ignore
D:\Retro\Toolchain\64tass\64tass-1.59.3120\64tass  --map "memory.map" --output-exec=start --c256-pgz "main.asm" --m65816 --list="memory.lst" -Wno-portable -o "maze.pgz"

Get-Process | Where-Object { $_.Description -eq "C256 FoenixIDE"} | Stop-Process -Force

Start-Process 'C:\Program Files\C256 Foenix Project\FoenixIDE Setup\FoenixIDE.exe'

D:\Retro\Foenix\Repos\FoenixMgr\tools\cmd\pcopy.bat maze.pgz