# syntax=docker/dockerfile:1.7
ARG ROS_VER=humble
ARG CARLA_VER=0.9.15
FROM docker.io/library/ros:${ROS_VER}

ARG ROS_VER
ARG CARLA_VER
ENV ROS_VER=${ROS_VER} \
    CARLA_VER=${CARLA_VER}

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    neovim \
    python3-pip \
    python-is-python3 \
    apt-utils \
    ros-${ROS_VER}-tf2-eigen

# Copy requirements file
COPY ros/requirements.txt /tmp/

# Install Python dependencies
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --upgrade pip \
 && python -m pip install -r /tmp/requirements.txt

# ROS Bridge Installation

SHELL ["/bin/bash", "-c"]

RUN cd /opt/ros/${ROS_VER}/include/tf2_eigen/ \
 && cp tf2_eigen/* ./

RUN mkdir -p /opt/carla-ros-bridge && cd /opt/carla-ros-bridge \
 && git clone --depth 1 --filter=blob:none --recurse-submodules --shallow-submodules \
      -b leaderboard-2.0 --single-branch \
      https://github.com/carla-simulator/ros-bridge.git src/ros-bridge

RUN cd /opt/carla-ros-bridge/src/ros-bridge/carla_ros_bridge/src/carla_ros_bridge \
 && sed -i "s/0.9.13/${CARLA_VER}/g" CARLA_VERSION

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=cache,target=/root/.ros/rosdep \
    /bin/bash -lc "source /opt/ros/${ROS_VER}/setup.bash \
 && cd /opt/carla-ros-bridge \
 && rosdep update \
 && rosdep install --from-paths src --ignore-src -r -y"

RUN /bin/bash -lc "source /opt/ros/${ROS_VER}/setup.bash \
 && cd /opt/carla-ros-bridge \
 && colcon build"

# Source the ROS setup.bash script
RUN echo "source /opt/ros/${ROS_VER}/setup.bash" >> ~/.bashrc \
 && echo "source /opt/carla-ros-bridge/install/setup.bash" >> ~/.bashrc
