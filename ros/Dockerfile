ARG ROS_VER=humble
FROM ros:${ROS_VER}

ARG ROS_VER
ENV ROS_VER ${ROS_VER}

ENV CARLA_VER ${CARLA_VER}

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    neovim \
    python3-pip \
    python-is-python3 \
    apt-utils \
    ros-${ROS_VER}-desktop

# Copy requirements file
COPY ros/requirements.txt /tmp/

# Install Python dependencies
RUN pip install --upgrade pip \
 && /usr/local/bin/pip install -r /tmp/requirements.txt

# ROS Bridge Installation

SHELL ["/bin/bash", "-c"]

RUN cd /opt/ros/${ROS_VER}/include/tf2_eigen/ \
 && cp tf2_eigen/* ./

RUN mkdir -p /opt/carla-ros-bridge && cd /opt/carla-ros-bridge \
 && git clone --recurse-submodules -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/ros-bridge.git src/ros-bridge

RUN cd /opt/carla-ros-bridge/src/ros-bridge/carla_ros_bridge/src/carla_ros_bridge \
 && sed -i "s/0.9.13/${CARLA_VER}/g" CARLA_VERSION

RUN source /opt/ros/${ROS_VER}/setup.bash \
 && cd /opt/carla-ros-bridge \
 && rosdep update \
 && rosdep install --from-paths src --ignore-src -r -y

RUN source /opt/ros/${ROS_VER}/setup.bash \
 && cd /opt/carla-ros-bridge \
 && colcon build

# Source the ROS setup.bash script
RUN echo "source /opt/ros/${ROS_VER}/setup.bash" >> ~/.bashrc \
 && echo "source /opt/carla-ros-bridge/install/setup.bash" >> ~/.bashrc

