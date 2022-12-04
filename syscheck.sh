navStatus=OFFLINE
reactorStatus=OFFLINE
engsysStatus=OFFLINE
mainengstatus=OFFLINE


mainenginefile="engine_control/engine_configuration/main_engines"
while IFS= read -r line
do
  # echo "$line"
  if [ $line == "status=ONLINE" ];
  then
     mainengstatus=ONLINE
     # echo "hi"
  fi
done < "$mainenginefile"

echo "Running systems check..."
sleep 1
echo "Navigation System $navStatus ..."
sleep 0.1
echo "Reactor Systems $reactorStatus..."
sleep 0.1
#echo "Engine Systems $engsysStatus..."
sleep 0.1
echo "Main Engines $mainengstatus..."
sleep 0.1
echo "Backup Terminal System ONLINE..."

sleep 1
echo -e "\n"
echo "Course: NO COURSE SET"
sleep 0.5
echo -e "\n"
echo "WARNING: ORBIT DETERIORATING. COLLISION WITH PLANET IMMINENT."


