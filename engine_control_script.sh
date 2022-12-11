# Main variable init--these may not be needed
navStatus=OFFLINE
reactorStatus=ONLINE
engsysStatus=OFFLINE
mainengstatus=OFFLINE
nav0=OFFLINE
nav1=OFFLINE

# Initializing file variables
mainenginefile="engine_control/engine_configuration/main_engines"
nav0file="engine_control/engine_configuration/nav_thruster_0"
nav1file="engine_control/engine_configuration/nav_thruster_1"
reactorfile="reactor_system/power_alloc.config.txt"
compassfile="nav_sys_control/pulsar_compass"
defaultfile="nav_sys_control/flight_paths/default"
break_orbit_file="nav_sys_control/flight_paths/break_orbit"
useless_directory_0="nav_sys_control/3ATTD"
orbit_file="nav_sys_control/flight_paths/orbit"

# These variables are set to 1 if the required challenges have been completed
enginePowerStatus=0
navigationStatus=0
# These variables are set to ONLINE if the required challenges have been completed
meStatus=OFFLINE
nav0Status=OFFLINE
nav1Status=OFFLINE

# Add nav checkers here
# Checks to see if there's the required line in pulsar_compass
compass_line_status=0
copied_file_status=1
useless_file_0_status=0
orbit_file_status=0
while IFS= read -r line
do
	if [ "$line" == "compass.activated" ];
	then
		compass_line_status=1
	fi
done < "$compassfile"

# Checks to see if break_orbit and default have the same text
while IFS= read -r line
do
	# echo $line
	if [ -f $break_orbit_file ];
	then	
		while IFS= read -r line2
		do
			if [ "$line2" == "$line" ];
			then
				useless_variable=0
				#echo "Remove this statement"
			else
				copied_file_status=0
			fi
		done < "$break_orbit_file"
	else
		copied_file_status=0
	fi
done < "$defaultfile"

if [ -d $useless_directory_0 ];
then
	useless_file_0_status=0
	echo -e "\n"
	echo "ERROR: unrecognized navigation file"
	sleep 0.75
	echo -e "\n"
else
	useless_file_0_status=1
fi

if [ -f $orbit_file ];
then
	orbit_file_status=1
fi

# Checks to see if each challenge has been completed
if [[ "$compass_line_status" == 1 ]] && [[ "$copied_file_status" == 1 ]] && [[ "$useless_file_0_status" == 1 ]] && [[ "$orbit_file_status" == 1 ]];
then
	navigationStatus=1
fi

# Activates navigation & nav thrusters if navigation challenges have been completed
if [ "$navigationStatus" == 1 ];
then
	navStatus=ONLINE
	nav0Status=ONLINE
	nav1Status=ONLINE
fi


while IFS= read -r line
do
	if [ "$line" == "engine-controllers=25" ];
	then
		enginePowerStatus=1
                # echo "$enginePowerStatus"
	fi
done < "$reactorfile"

echo "Running systems check..."
sleep 1
echo "Navigation System $navStatus ..."
sleep 0.1
# echo "Reactor Systems $reactorStatus..."
sleep 0.1
# echo "Engine Systems $engsysStatus..."
# sleep 0.1
echo -e "\n"
sleep 0.25
echo "Backup Terminal System ONLINE..."

sleep 1
echo -e "\n"
echo "Course: NO COURSE SET"
sleep 0.5
echo -e "\n"
echo "WARNING: ORBIT DETERIORATING. COLLISION WITH PLANET IMMINENT."

# Move the following comments to above the loops and if statements

# Add checker to see if reactor config file has been edited

# Add checker to see if navigation directory has been restored to proper format

# Rewrite engine files (mainenginefile, nav0file, nav1file) with status=OFFLINE if all checkers read ONLINE

# statusVar=$(source ./syscheck.sh $mainengstatus)

# echo "status is $statusVar"

# source ./syscheck.sh

echo -e "\n"
echo "---------"
echo -e "\n"
echo "Launching engine control..."
sleep 0.75
echo "Registering main engines..."
sleep 1
echo "Registering thrusters..."
sleep 1
echo -e "\n"

if [ $enginePowerStatus == 1 ];
then
    echo "Power: sufficient power"
    echo "Bringing main engines online."
else
    echo "WARNING: Insufficient power. Unable to bring engine controllers online."
    exit
fi

if [ "$navigationStatus" == 1 ];
then
    echo "Calibrating nav systems..."
    sleep 0.1
    echo "Nav systems online."
    echo "Bringing nav thrusters online."
else
    echo "ERROR: nav system error"
    echo "Unable to bring navigation thruster controllers online."
    exit
fi
if [[ "$enginePowerStatus" == 1 ]] && [[ "$navigationStatus" == 1 ]];
then
    meStatus=ONLINE
fi

echo -e "\n"
echo "Main engines $meStatus"
sleep 0.1
echo "Navigational thruster 0 $nav0Status"
sleep 0.1
echo "Navigational thruster 1 $nav1Status"
sleep 0.1
echo -e "\n"


if [[ $meStatus == OFFLINE ]] || [[ $nav0Status == OFFLINE ]] || [[ $nav1Status == OFFLINE ]];
then
    echo "ERROR: Unable to bring engines online."
    sleep 2
    exit
else
    echo "ALL ENGINES ONLINE"
    echo -e "\n"
fi
# echo "Engines online."

success(){
	touch success.txt
	echo "Congratulations, Captain! You saved your ship from destruction. And what's more important, you (hopefully) improved your skills with the Linux command line." >> success.txt
	echo "If you're interested in improving your skills further (and preventing further disasters), check out the websites below." >> success.txt
	echo "Who knows--Cygnus IV may need you again someday." >> success.txt
	sleep 3
	echo "You did it! Check the success.txt file for your reward."
}

checkCommand(){
	input=$1
	# echo "$input"
	if [ "$input" == "engines.engage" ];
	then
		echo "Calibrating reactor feed..."
		sleep 0.1
		echo "Calibrating navigation..."
		sleep 0.5
		echo "Setting course to break_orbit..."
		sleep 1
		echo "Engaging engines..."
		sleep 0.25
		echo "ENGINES FIRING"
		sleep 3
		echo "Nav: break_orbit complete"
		sleep 2
		echo "Shutting down engines..."
		sleep 1.25
		echo "Engines shut down."
		sleep 1.5
		echo -e "\n"
		echo "Out of orbit."
		echo -e "\n"
		success
	else  
		echo "Command not recognized."
	fi
}

while :
do
read -p "Enter command: " commandIn
checkCommand $commandIn
done
