ARG CARLA_VER=0.9.15
FROM carlasim/carla:${CARLA_VER}

ARG CARLA_VER

USER root

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/3bf863cc.pub

RUN apt-get update && apt-get install -y --no-install-recommends \
    vulkan-utils \
    neovim \
    libjpeg8 \
    libtiff5 \
    xdg-user-dirs \
    apt-utils \
    git \
    python3-pip \
    python3-setuptools \
    ubuntu-mono

# Scenario Runner
COPY -scenario_runner-requirements.txt /tmp/

RUN pip3 install --upgrade pip \
 && /usr/local/bin/pip3 install -r /tmp/scenario_runner-requirements.txt

RUN cd /opt \
 && git clone -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/scenario_runner.git

# Leaderboard
COPY leaderboard-requirements.txt /tmp/

RUN pip3 install --upgrade pip \
 && /usr/bin/pip3 install -r /tmp/leaderboard-requirements.txt

RUN cd /opt \
 && git clone -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/leaderboard.git

ENV CARLA_ROOT=/home/carla
ENV SCENARIO_RUNNER_ROOT=/opt/scenario_runner
ENV LEADERBOARD_ROOT=/opt/leaderboard
ENV PYTHONPATH=${SCENARIO_RUNNER_ROOT}:${PYTHONPATH}
ENV PYTHONPATH=${LEADERBOARD_ROOT}:${PYTHONPATH}
ENV PYTHONPATH=${CARLA_ROOT}/PythonAPI/carla/dist/carla-${CARLA_VER}-py3.7-linux-x86_64.egg:${PYTHONPATH}
ENV PYTHONPATH=${CARLA_ROOT}/PythonAPI/carla:${PYTHONPATH}
