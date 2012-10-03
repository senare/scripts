#!/bin/bash

cd /home/senare/anarchy/drive_c/Program\ Files/

env WINEARCH=win32 WINEPREFIX=~/anarchy wine ClickSaver310.exe > /dev/null 2>&1 &

echo  'Anarchy Main PID' $!
