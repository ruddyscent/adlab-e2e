# syntax=docker/dockerfile:1.7
ARG CARLA_VER=0.9.15
FROM docker.io/carlasim/carla:${CARLA_VER}

ARG CARLA_VER
ENV CARLA_ROOT=/home/carla

USER root

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
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
