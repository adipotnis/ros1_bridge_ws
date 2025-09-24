#!/bin/bash
set -e

# Source ROS1 Noetic and ROS2 Foxy environments
source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash

# Source the built workspace (if it exists)
if [ -f /workspace/install/local_setup.bash ]; then
    source /workspace/install/local_setup.bash
    echo "WS found!"
else
    echo "WS not found!"
fi

if [ -f /workspace/ros1_ws/devel/local_setup.bash ]; then
    source /workspace/ros1_ws/devel/local_setup.bash
    echo "ros1 custom msgs WS found!"
else
    echo "ros1 custom msgs WS not found!"
fi

if [ -f /workspace/ros2_ws/install/local_setup.bash ]; then
    source /workspace/ros2_ws/install/local_setup.bash
    echo "ros2 custom msgs WS found!"
else
    echo "ros2 custom msgs WS not found!"
fi
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Execute the command passed to the container
exec "$@"
