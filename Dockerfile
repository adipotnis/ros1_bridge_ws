FROM ros:foxy-ros-base

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt update && apt install -y \
    software-properties-common \
    curl \
    wget \
    git \
    lsb-release \
    gnupg2 \
    python3-colcon-common-extensions \
    python3-rosdep \
    locales && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8


RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1.list && \
    apt update && apt install -y \
        ros-noetic-ros-base \
        ros-noetic-octomap-msgs && \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y \
    ros-foxy-octomap-msgs && \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y \
    ros-noetic-tf2-msgs \
    ros-foxy-tf2-msgs

RUN rm -f /etc/ros/rosdep/sources.list.d/20-default.list && \
    rosdep init && \
    rosdep update

WORKDIR /workspace
RUN git clone https://github.com/ros2/ros1_bridge.git -b foxy
# build ros1_bridge by sourcing ROS1 and ROS2 env
RUN /bin/bash -c " \
    source /opt/ros/noetic/setup.bash && \
    source /opt/ros/foxy/setup.bash && \
    colcon build --symlink-install --parallel-workers 2 --packages-select ros1_bridge \
"
RUN apt update && apt install -y ros-foxy-rmw-cyclonedds-cpp

COPY entrypoint.sh /entrypoint.sh
COPY bridge.launch.py /bridge.launch.py
RUN chmod +x /entrypoint.sh
RUN chmod +x /bridge.launch.py

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["bash"]
CMD ["ros2", "launch", "/bridge.launch.py"]
