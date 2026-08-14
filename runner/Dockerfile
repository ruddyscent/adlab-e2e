# syntax=docker/dockerfile:1.7
FROM nvcr.io/nvidia/pytorch:24.08-py3
# FROM python:3.9.19

ARG CARLA_VER=0.9.15

# USER root

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
   neovim \
   python3-pip \
   python3-setuptools \
   libjpeg8 \
   libtiff5 \
   xdg-user-dirs \
   apt-utils \
   git \
   ubuntu-mono \
   fontconfig \
   wget \
   libgl1-mesa-glx \
   x11-utils

# RUN pip uninstall -y opencv \
#  && apt-get install -y --no-install-recommends \
#    python3-opencv
   # python3-opencv \
   # libgtk2.0-dev \
   # pkg-config \
   # x11-apps

# Resolve and install all Python dependencies once. The cache survives rebuilds
# without being committed to the resulting image layer.
COPY runner/runner-requirements.txt \
     runner/scenario_runner-requirements.txt \
     runner/leaderboard-requirements.txt /tmp/requirements/

RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --upgrade pip \
 && python -m pip uninstall -y opencv \
 && rm -rf /usr/local/lib/python3.10/dist-packages/cv2 \
 && python -m pip install \
      opencv-python \
      -r /tmp/requirements/runner-requirements.txt \
      -r /tmp/requirements/scenario_runner-requirements.txt \
      -r /tmp/requirements/leaderboard-requirements.txt

RUN cd /opt \
 && git clone --depth 1 --filter=blob:none -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/scenario_runner.git

# https://github.com/carla-simulator/leaderboard/pull/182
RUN sed -i 's/scenario.getchildren()/list(scenario)/g' /opt/scenario_runner/srunner/tools/scenario_parser.py

RUN cd /opt \
 && git clone --depth 1 --filter=blob:none -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/leaderboard.git

# https://github.com/carla-simulator/leaderboard/pull/182
RUN sed -i 's/scenario.getchildren()/list(scenario)/g' /opt/leaderboard/leaderboard/utils/route_parser.py

# CARLA
RUN cd /opt \
 && git clone --depth 1 --filter=blob:none -b ${CARLA_VER} --single-branch https://github.com/carla-simulator/carla.git
 
#COPY CARLA_${CARLA_VER}.tar.gz /opt/
#
#RUN cd /opt/ \
# && mkdir carla \
# && tar xfz CARLA_${CARLA_VER}.tar.gz -C carla \
# && rm CARLA_${CARLA_VER}.tar.gz

ENV SCENARIO_RUNNER_ROOT=/opt/scenario_runner \
    LEADERBOARD_ROOT=/opt/leaderboard \
    CARLA_ROOT=/opt/carla \
    PYTHONPATH=/opt/scenario_runner:/opt/leaderboard:/opt/carla/PythonAPI/carla
