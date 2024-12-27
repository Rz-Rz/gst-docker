#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
export CLANG_VERSION=12

# This list is huge. Need to slim it down.
# We do not need dev tools in the final image AFAIK
sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list
apt-get update
apt-get install -y --no-install-recommends \
  autotools-dev \
  autoconf \
  libtool \
  libtool-bin \
  build-essential \
  glibc-tools \
  pkg-config \
  gcc \
  g++ \
  nasm \
  clang-$CLANG_VERSION \
  cmake \
  flex \
  bison \
  git \
  wget \
  curl \
  unzip \
  libssl-dev \
  libva-dev \
  zlib1g-dev \
  graphviz \
  ninja-build \
  python3 \
  python3-pip \
  gettext \
  iso-codes \
  bubblewrap \
  xdg-dbus-proxy \
  gperf \
  pkg-config \
  zlib1g-dev \
  ninja-build \
  bzip2 \
  libmount-dev \

pip3 install meson tomli

  #future use
  # libwayland-client0 \
  # libwayland-egl1 \
  # libwayland-server0 \
  # wayland-protocols \
  # libwayland-dev \

# ARCH=$(dpkg --print-architecture)
# if [[ $ARCH == "amd64" ]]; then
#    apt-get install -y --no-install-recommends \
#      libmfx-dev \
#      intel-media-va-driver-non-free
# fi

apt-get clean
rm -rf /var/lib/apt/lists/*
