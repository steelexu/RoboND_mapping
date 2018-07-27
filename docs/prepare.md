

* Make sure the files in /script folder have the +x permission

 catkin_create_pkg   kitchen_slam

* prepare the world

curl -L https://s3-us-west-1.amazonaws.com/udacity-robotics/Term+2+Resources/P3+Resources/models.tar.gz | tar zx -C ~/.gazebo/

* in world.launch, include the robot_description.launch from previous project
	also copy the mesh and urdf of udacity_bot
set an arg named "world_file"  for kitchen_dining.world

* prepare  batch file slam_rtab.sh, change the package name in rviz.launch

* prepare the teleop.launch, change the topic in scripts ~cmd_vel to /cmd_vel
	into src directory
	?remap?

* copy mapping.launch from lesson
** change the topic remap

* udacity_bot.gazebo, replace camera with kinect
   change hokayo topic /scan
** xacro add  <joint>   camera_rgbd_joint, make sure its direction, attach    camera_rgbd_frame to it

rqt _graph  tf view_frames
* Error="canTransform: source_frame camera_rgbd_frame does not exist.. canTransform returned after 0.2 timeout was 0.2.".

* https://answers.ros.org/question/232534/gazebo-camera-frame-is-inconsistent-with-rviz-opencv-convention/
https://github.com/code-iai/iai_kinect2/issues/180
http://answers.gazebosim.org/question/4266/gazebo-15-libgazebo_openni_kinectso-pointcloud-data-is-rotated-and-flipped/
