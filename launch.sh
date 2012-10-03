#!/bin/bash
cd /mnt/public/home/73_mans/mans/Anarchy\ Online/
env WINEARCH=win32 WINEPREFIX=~/$1 wine Anarchy.exe > /dev/null 2>&1 &
