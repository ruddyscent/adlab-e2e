FROM nvcr.io/nvidia/pytorch:24.07-py3

ARG CARLA_VER=${CARLA_VER}

# USER root

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
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
   wget

# Copy requirements file
COPY runner/jupyter-requirements.txt /tmp/

# Change permissions of pip cache directory (if necessary)
RUN mkdir -p /home/jovyan/.cache/pip \
 && chown -R root:root /home/jovyan/.cache/pip

# Install Python dependencies
RUN pip install --upgrade pip \
 && /usr/local/bin/pip install -r /tmp/jupyter-requirements.txt

# Install Scenario Runner
COPY runner/scenario_runner-requirements.txt /tmp/

RUN pip3 install --upgrade pip \
 && /usr/local/bin/pip3 install -r /tmp/scenario_runner-requirements.txt

RUN cd /opt \
 && git clone -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/scenario_runner.git

# https://github.com/carla-simulator/leaderboard/pull/182
RUN sed -i 's/scenario.getchildren()/list(scenario)/g' /opt/scenario_runner/srunner/tools/scenario_parser.py

# Install Leaderboard
COPY runner/leaderboard-requirements.txt /tmp/

RUN pip3 install --upgrade pip \
 && /usr/local/bin/pip3 install -r /tmp/leaderboard-requirements.txt

RUN cd /opt \
 && git clone -b leaderboard-2.0 --single-branch https://github.com/carla-simulator/leaderboard.git

# https://github.com/carla-simulator/leaderboard/pull/182
RUN sed -i 's/scenario.getchildren()/list(scenario)/g' /opt/leaderboard/leaderboard/utils/route_parser.py

# CARLA
RUN cd /opt \
 && git clone -b ${CARLA_VER} --single-branch https://github.com/carla-simulator/carla.git 
 
#COPY CARLA_${CARLA_VER}.tar.gz /opt/
#
#RUN cd /opt/ \
# && mkdir carla \
# && tar xfz CARLA_${CARLA_VER}.tar.gz -C carla \
# && rm CARLA_${CARLA_VER}.tar.gz

ENV SCENARIO_RUNNER_ROOT=/opt/scenario_runner
ENV LEADERBOARD_ROOT=/opt/leaderboard
ENV PYTHONPATH=${SCENARIO_RUNNER_ROOT}:${PYTHONPATH}
ENV PYTHONPATH=${LEADERBOARD_ROOT}:${PYTHONPATH}
ENV CARLA_ROOT=/opt/carla
# ENV PYTHONPATH=${PYTHONPATH}:${CARLA_ROOT}/PythonAPI/carla/dist/carla-${CARLA_VER}-py3.7-linux-x86_64.egg
ENV PYTHONPATH=${PYTHONPATH}:${CARLA_ROOT}/PythonAPI/carla
