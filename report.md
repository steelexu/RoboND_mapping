
# Map My World

## Abstract

This project complete the mapping task with provided environment and customized world, work including: setup the world, equip the robot, and debugging with ros tool.  Utilizing  with rtab-slam toolchain, environment's 2d   occupancy grid map and 3D point cloud are generated

## Introduction 

To fullfill various task, the robot need a map of the unknown environment while simultaneously localizing itself in this map, Learning maps under pose uncertainty is often referred to as the simultaneous localization and mapping (SLAM) problem. Such SLAM process is only based on robot on-board sensors and without relying on external GPS



## Background 



There are mainly two approach to SLAM,

* Particle Filter Approach ; FASTSLAM need predefined landmark positions, gmapping adapts FastSLAM into grid map without landmark. Filtering approaches model the problem as an on-line state estimation which is augmented and refined by incorporating the new measurements as they become available.
* Graph optimization Approach ;Solving a graph-based SLAM problem involves to construct a graph whose nodes represent robot poses or landmarks and in which an edge between two nodes encodes a sensor measurement that constrains the connected poses. Such optimization of constrains is done in the backend (in rtab it's left to vertigo/g2o), and the frontend will deal with input from sensor, one of step in frontend is loop dectection where rtab is good at.

### RTAB

[rtab](https://raw.githubusercontent.com/wiki/introlab/rtabmap/doc/Labbe2015ULavalOverview.jpg)

RTAB-Map (Real-Time Appearance-Based Mapping) is a RGB-D, Stereo and Lidar Graph-Based SLAM approach based on an incremental appearance-based loop closure detector. The loop closure detector uses a bag-of-words approach to determinate how likely a new image comes from a previous location or a new location. When a loop closure hypothesis is accepted, a new constraint is added to the map’s graph, then a graph optimizer minimizes the errors in the map. A memory management approach is used to limit the number of locations used for loop closure detection and graph optimization, so that real-time constraints on large-scale environnements are always respected.  


 

## Model Configuration & World Creation

### Aside from the provided  world,  my personal world consist of stairs and table and standing person.  surrounding with wall and window. This world is created in the building editor of gazebor, save as world/house1.world
![house-world][house-world-img]


### 2-wheel robot is from previous lesson(udacity_bot) , with a hokuyo scan and replace camera with kinect(RGBD camera),package inherit a lot from  udacity_bot, adopting scripts from Student+Project+Materials.zip, adding some new launch file

slam_rtab.sh  integrating all these launch file, afford to start the mapping environment

whole setup tf tree is here, also see the docs/frames.pdf
![tf-tree][tf-tree-img]





#### trouble shooting

but I got error initialy

[ WARN]  Could not get transform from robot_footprint to camera_rgbd_frame after 0.200000 seconds (for stamp=20.723000)
Error="canTransform: source_frame camera_rgbd_frame does not exist

from [tips](https://answers.ros.org/question/232534/gazebo-camera-frame-is-inconsistent-with-rviz-opencv-convention/)
solution: in udacity_bot.xacro ,add  <joint>  of camera_rgbd_joint, attach link of  camera_rgbd_frame to it

## Results
 

### kitchen world

map process, 156 loop closure
![kitchen-process][kitchen-process-img]
![kitchen-viewer][kitchen-viewer-img]
2d map
![kitchen-2d][kitchen-2d-img]

3d map
![kitchen-3d][kitchen-3d-img]

### my world

2d map
![house-2d][house-2d-img]

3d map
![house-3d][house-3d-img]

map process, 10 loop closure
![house-process][house-process-img]
![house-viewer][house-viewer-img]

##  Discussion  

Sometime in the teleop of robot, robot resist to go,  very slow, maybe the computation increase(now configuration is visual words per image (bag-of-words) 400, SURF features  100), here need to further investigate

In the mapping process try to use rtabmapviz to monitoring, and use the rtab-databaseviewer to analyze afterwards
the provided world is  feature-rich enough to get relative perfect result, but my customized world has less feature, so some loop closure is false(need to reject in  constraint view) , and the stair is drift and distorted



## Future Work. 


I would like do further mapping with a drone model by rtab-ROS, where the 3D point cloud will be more meaningful for the navigation of drone. 


[tf-tree-img]: ./docs/rosgraph.png
[kitchen-2d-img]: ./docs/kitchen/2d.jpg
[kitchen-3d-img]: ./docs/kitchen/3d.png
[kitchen-process-img]: ./docs/kitchen/in-process.png
[kitchen-viewer-img]: ./docs/kitchen/in-viewer.png

[house-2d-img]: ./docs/house/2d.png
[house-3d-img]: ./docs/house/3d.png
[house-process-img]: ./docs/house/process.png
[house-world-img]: ./docs/house/world.png
[house-viewer-img]: ./docs/house/viewer.png
