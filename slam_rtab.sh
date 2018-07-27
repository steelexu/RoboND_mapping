#!/bin/sh

# test slam
#export TURTLEBOT_GAZEBO_WORLD_FILE=$(rospack find  kitchen_slam)/world/house1.world
#xterm -e "roslaunch kitchen_slam world.launch" &

xterm -e "roslaunch kitchen_slam world.launch world_file:=$(rospack find  kitchen_slam)/world/kitchen_dining.world" &
sleep 5

xterm -e "roslaunch kitchen_slam teleop.launch"&
sleep 5


#xterm -e "rosrun rqt_console  rqt_console"&
#sleep 5

#xterm -e "roslaunch turtlebot_teleop keyboard_teleop.launch"&
#sleep 5

xterm -e "roslaunch kitchen_slam mapping.launch simulation:=true"&
sleep 5

xterm -e "roslaunch kitchen_slam rviz.launch"&
