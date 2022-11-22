navStatus=OFFLINE
reactorStatus=OFFLINE
engsysStatus=OFFLINE


echo "Running systems check..."
sleep 2
echo "Navigation System $navStatus ..."
sleep 0.25
echo "Reactor Systems $reactorStatus..."
sleep 0.25
echo "Engine Systems $engsysStatus..."
sleep 0.25
echo "Backup Terminal System ONLINE..."

sleep 1
echo -e "\n"
echo "Course: NO COURSE SET"
sleep 0.5
echo -e "\n"
echo "WARNING: ORBIT DETERIORATING. COLLISION WITH PLANET IMMINENT."


