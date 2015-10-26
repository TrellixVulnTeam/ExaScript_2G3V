@echo off
setlocal

if [%1]==[] goto usage

set _root=%~dp0
set _local_dlr_path_file=%_root%.local-dlr-path.props

if [%1]==[none] goto remove-config
set _dlr_root=%~dpn1
if not exist %_dlr_root% goto not-found


:set-config
echo ^<?xml version="1.0" encoding="utf-8"?^> > "%_local_dlr_path_file%"
echo ^<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003"^> >> "%_local_dlr_path_file%"
echo   ^<PropertyGroup^> >> "%_local_dlr_path_file%"
echo     ^<DlrReferences^>%_dlr_root%\bin\$(Configuration)^</DlrReferences^> >> "%_local_dlr_path_file%"
echo   ^</PropertyGroup^> >> "%_local_dlr_path_file%"
echo ^</Project^> >> "%_local_dlr_path_file%"
goto:eof

:remove-config
del /Q "%_local_dlr_path_file%"
goto:eof

:usage
echo %~n0 ^<path^\to^\dlr^>
echo %~n0 none
exit /B 1

:not-found
echo %_dlr_root% does not exist.
exit /B 2

:exit
endlocal
