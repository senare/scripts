#!/bin/bash
INPUT=/tmp/menu.sh.$$
 
# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$
 
# get text editor or fall back to vi_editor
vi_editor=${EDITOR-vi}
 
# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM
 
#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#

function display_output(){
	local h=${1-100}		# box height default 10
	local w=${2-60} 		# box width default 41
	local t=${3-Output} 	 	# box title 
	dialog --backtitle "Anarchy Online launcher" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}

function launch_cs_main(){
  bash /mnt/public/home/xdotool/launch_cs.sh &
}

function launch_main(){
  bash /mnt/public/home/xdotool/launch_main.sh &
}

function launch_1-5(){
  bash /mnt/public/home/xdotool/launch_1-5.sh &
}

function launch_5-7(){
  bash /mnt/public/home/xdotool/launch_5-7.sh &
}

function launch_8-9(){
  bash /mnt/public/home/xdotool/launch_8-9.sh &
}

function start_workboy(){
  bash /mnt/public/home/xdotool/workboy &
}

function stop_workboy(){
  PID=$(ps -ef | grep '/mnt/public/home/xdotool/workboy' | grep -v grep | awk '{print $2}')
  $(kill $PID)
}


function start_nuke(){
  bash /mnt/public/home/xdotool/nuke &
  bash /mnt/public/home/xdotool/mongo &
}
function stop_nuke(){
  PID=$(ps -ef | grep '/mnt/public/home/xdotool/nuke' | grep -v grep | awk '{print $2}')
  $(kill $PID)
  PID=$(ps -ef | grep '/mnt/public/home/xdotool/mongo' | grep -v grep | awk '{print $2}')
  $(kill $PID)
}

function start_aggro(){
  bash /mnt/public/home/xdotool/aggro &
}
function stop_aggro(){
  PID=$(ps -ef | grep '/mnt/public/home/xdotool/aggro' | grep -v grep | awk '{print $2}')
  $(kill $PID)
}



#
# set infinite loop
#
while true
do
 
### display main menu ###
dialog --clear  --help-button --backtitle "Anarchy Online launcher" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 50 15 \
LAUNCH_MAIN "Launch Anarchy Online" \
LAUNCH_CS "Launch clicksaver (mainn)" \
LAUNCH_1-5 "Launch Anarchy Online (bottle 1-5)" \
LAUNCH_5-7 "Launch Anarchy Online (bottle 5-7)" \
LAUNCH_8-9 "Launch Anarchy Online (bottle 8-9)" \
WORKBOY_START "Run DD (Workboy)" \
WORKBOY_STOP "Stop DD (Workboy)" \
NUKE_START "Start nukes (Aggroboy,wrNuke)" \
NUKE_STOP "Stop nukes (Aggroboy,wrNuke)" \
MONGO_START "Start mongo (Aggroboy)" \
MONGO_STOP "Stop mongo (Aggroboy)" \
Exit "Exit to the shell" 2>"${INPUT}"
 
menuitem=$(<"${INPUT}")
 
 
# make decsion 
case $menuitem in
        LAUNCH_MAIN) launch_main;;
        LAUNCH_CS) launch_cs_main;;
        LAUNCH_1-5) launch_1-5;;
        LAUNCH_5-7) launch_5-7;;
        LAUNCH_8-9) launch_8-9;;
	WORKBOY_START) start_workboy;;
	WORKBOY_STOP) stop_workboy;;
	NUKE_START) start_nuke;;
	NUKE_STOP) stop_nuke;;
	MONGO_START) start_aggro;;
	MONGO_STOP) stop_aggro;;
	Exit) echo "Bye"; break;;
esac
 
done
 
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
