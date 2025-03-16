#!/bin/bash
set -e

# Source ROS1 Noetic and ROS2 Foxy environments
source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash

# Source the built workspace (if it exists)
if [ -f /workspace/install/local_setup.bash ]; then
    source /workspace/install/local_setup.bash
else
    echo "WS not found!"
fi

export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Execute the command passed to the container
exec "$@"
