# FROM quay.io/jupyter/pytorch-notebook:cuda11-python-3.11.9
FROM nvcr.io/nvidia/pytorch:24.05-py3

# USER root

# Let us install tzdata painlessly
# ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
   neovim \
   python3-pip \
   python3-setuptools \
   vulkan-utils \
   libjpeg8 \
   libtiff5 \
   xdg-user-dirs \
   apt-utils \
   git \
   ubuntu-mono 

# Copy requirements file
COPY jupyter-requirements.txt /tmp/

# Change permissions of pip cache directory (if necessary)
# RUN mkdir -p /home/jovyan/.cache/pip \
#  && chown -R root:root /home/jovyan/.cache/pip

# Install Python dependencies
RUN pip install --upgrade pip \
 && /usr/local/bin/pip install -r /tmp/jupyter-requirements.txt

