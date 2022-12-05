navStatus=OFFLINE
reactorStatus=OFFLINE
engsysStatus=OFFLINE
mainengstatus=OFFLINE
nav0=OFFLINE
nav1=OFFLINE

mainenginefile="engine_control/engine_configuration/main_engines"
nav0file="engine_control/engine_configuration/nav_thruster_0"
nav1file="engine_control/engine_configuration/nav_thruster_1"

# add in more checkers that will set the thruster files to online if all the conditions are met (reactor file has been edited, nav system has been repaired)

while IFS= read -r line
do
  # echo "$line"
  if [ $line == "status=ONLINE" ];
  then
     mainengstatus=ONLINE
     # echo "hi"
  fi
done < "$mainenginefile"

while IFS= read -r line
do
	if [ $line == "status=ONLINE" ];
	then
		nav0=ONLINE
	fi
done < "$nav0file"

while IFS= read -r line
do
	if [ $line == "status=ONLINE" ];
	then
		nav1=ONLINE
	fi
done < "$nav1file"

# Set up a way to have the engine checker pull the systems status from this file.


echo "Running systems check..."
sleep 1
echo "Navigation System $navStatus ..."
sleep 0.1
echo "Reactor Systems $reactorStatus..."
sleep 0.1
# echo "Engine Systems $engsysStatus..."
# sleep 0.1
echo -e "\n"
echo "Main Engines $mainengstatus..."
sleep 0.1
echo "Navigation thruster 0 $nav0..."
sleep 0.1
echo "Navigation thruster 1 $nav1..."
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


