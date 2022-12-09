navStatus=OFFLINE
reactorStatus=OFFLINE
engsysStatus=OFFLINE
mainengstatus=OFFLINE
nav0=OFFLINE
nav1=OFFLINE

mainenginefile="engine_control/engine_configuration/main_engines"
nav0file="engine_control/engine_configuration/nav_thruster_0"
nav1file="engine_control/engine_configuration/nav_thruster_1"
reactorfile="reactor_system/power_alloc.config.txt"

enginePowerStatus=0
# Set the variable below to 0 initially and have a checker set up to make sure it's been completed
navigationStatus=1

meStatus=OFFLINE
nav0Status=OFFLINE
nav1Status=OFFLINE

# add in more checkers that will set the thruster files to enabled if all the conditions are met (reactor file has been edited, nav system has been repaired)

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
                echo "$enginePowerStatus"
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
echo "Main Engines $mainengstatus..."
sleep 0.1
echo "Navigation thruster 0 $nav0Status..."
sleep 0.1
echo "Navigation thruster 1 $nav1Status..."
sleep 0.1
echo -e "\n"
sleep 0.25
echo "Backup Terminal System ONLINE..."

sleep 1
echo -e "\n"
echo "Course: NO COURSE SET"
sleep 0.5
echo -e "\n"
echo "WARNING: ORBIT DETERIORATING. COLLISION WITH PLANET IMMINENT."




mainenginefile="engine_configuration/main_engines"
nav0file="engine_configuration/nav_thruster_0"
nav1file="engine_configuration/nav_thruster_1"
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
    echo "Unable to bringing navigation thruster controllers online."
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


read -p "Enter command: " commandIn
