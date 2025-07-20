This repo is inteneded to record issues and fixes related to Windows 10.
The format of record includes but is not limited to the following

- Text, such as markdown or pdf
- batch scripts
- program installers

Hope this helps anyone finding themselves in the same shoes, and contributions are welcome and appreciated!

#About Software Installation Packages
All software installation packages were found online and are provided here as-is. USE AT YOUR OWN RISK
I will provide the source of each installation package. Not all software here are _portable_

##Autoruns
https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns
Shows you the currently configured auto-start applications as well as the full list of Registry and file system locations available for auto-start configuration.

##Process Explorer
https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
A more sophisticated version of process management than that provided in Task Manager.

##Process Monitor
http://learn.microsoft.com/en-us/sysinternals/downloads/procmon
Used for monitoring and profiling CPU, Disk, Internet activity of processes. Again, a more sophisticated version than that
provided in Task Manager. 

##WinDBG
https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/
Used to read crash dump files. I mostly found it useful for fixing Localization/Compatability issues
for certain visual novels.

##Synctoy
_source: none_
Deprecated by MS many years ago. Useful for backing up stuff, especially automated backups as it supports
command line arguments

[To-do]
Check and comment on portability of Autoruns, Process Explorer, Process Monitor, WinDBG, Synctoy
