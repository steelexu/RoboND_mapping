#report.md

#

Abstract, 

##   - Student gives a high-level overview of what is being attempted in the report. 
Abstracts are typically 5-10 sentences that provide just enough context to understand the gist of the report.

## Introduction - Student can clearly and accurately explain the problem domain.

## Background 
importance of both mapping
  into the scope  also identifying some of the current challenges in robot mapping

They further discuss and compare mapping algorithms
*  use landmark




All of these optimizations use node poses and link transformations as constraints. 
When a loop closure is detected, errors introduced by the odometry can be propagated to all links, correcting the map.


## Model Configuration, World Creation,

![house-world][house-world-img]
my personal world consist of stairs and table and standing person.  surrounding with wall and window. 
This world is created in the building editor of gazebor, save as world/house1.world


2-wheel robot is from previous lesson(udacity_bot) , with a hokuyo scan and replace camera with kinect(RGBD camera)

package inherit a lot from  udacity_bot, adopting scripts from Student+Project+Materials.zip, adding some new launch file

tf tree is here
![tf-tree][tf-tree-img]

slam_rtab.sh  integrate all these launch file, afford to start the mapping environment



but I got error

[ WARN]  Could not get transform from robot_footprint to camera_rgbd_frame after 0.200000 seconds (for stamp=20.723000)
Error="canTransform: source_frame camera_rgbd_frame does not exist

from [tips](https://answers.ros.org/question/232534/gazebo-camera-frame-is-inconsistent-with-rviz-opencv-convention/)
solution: in udacity_bot.xacro ,add  <joint>  of camera_rgbd_joint, attach link of  camera_rgbd_frame to it

# Results, 
images for mapping process, final map (2D/3D) for both Gazebo worlds.
occupancy grid and 3D map. 

## kitchen world

map process
![kitchen-process][kitchen-process-img]

2d map
![kitchen-2d][kitchen-2d-img]

3d map
![kitchen-3d][kitchen-3d-img]

## my world

2d map
![house-2d][]

3d map
![house-3d][]

map process
![house-process][house-process-img]

#  Discussion - performance, wrong
 The student explains how the procedure went and methodologies to improve it. 

teleop to turn 3 rounds?  rtabmapviz to monitoring...
rqt_image_view to tracking

 feature-rich enough to make global loop closure

## The student should compare and contrast the performance of RTAB Mapping in different worlds.

* visual words per image (bag-of-words) 400, SURF features  100
* [ WARN] (2018-07-23 19:42:11.404) Rtabmap.cpp:1913::process() Rejected loop closure 59 -> 1215: Not enough features in images (old=7, new=288, min=15)
By providing constraints associated with how many nodes are processed for loop closure by memory management, the time complexity becomes constant in RTAB-Map.
Graph-SLAM complexity is linear, according to the number of nodes, which increases according to the size of the map.

# Future Work. 





[tf-tree-img]: ./docs/rosgraph.png
[kitchen-2d-img]: ./docs/kitchen/2d.jpg
[kitchen-3d-img]: ./docs/kitchen/3d.png
[kitchen-process-img]: ./docs/kitchen/in-process.png
[house-2d-img]: ./docs/house/2d.png
[house-3d-img]: ./docs/house/3d.png
[house-process-img]: ./docs/house/process.png
[house-world-img]: ./docs/house/world.png

Mapping Best Practices

Our goal is to create a great map with the least amount of passes as possible. Getting 3 loop closures will be sufficient for mapping the entire environment. You can maximize your loop closures by going over similar paths two or three times. This allows for the maximization of feature detection, facilitating faster loop closures! When you are done mapping, be sure to copy or move your database before moving on to map a new environment. Remember, relaunching the mapping node deletes any database in place on launch start up!

