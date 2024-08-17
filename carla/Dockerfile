ARG CARLA_VER=${CARLA_VER}
FROM carlasim/carla:${CARLA_VER}

ARG CARLA_VER=${CARLA_VER}
ENV CARLA_ROOT=/home/carla

USER root

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

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
    ubuntu-mono \
    wget

COPY AdditionalMaps_${CARLA_VER}.tar.gz ${CARLA_ROOT}/Import/

RUN ${CARLA_ROOT}/ImportAssets.sh \
 && rm ${CARLA_ROOT}/Import/AdditionalMaps_${CARLA_VER}.tar.gz

