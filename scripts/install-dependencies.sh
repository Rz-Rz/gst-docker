#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
export CLANG_VERSION=12

# This list is huge. Need to slim it down.
# We do not need dev tools in the final image AFAIK
sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list
apt-get update
apt-get dist-upgrade -y
apt-get install -y --no-install-recommends \
  ca-certificates \
  fonts-ipafont-gothic \
  fonts-wqy-zenhei \
  fonts-thai-tlwg \
  fonts-kacst \
  fonts-beng \
  fonts-nafees \
  fonts-sil-padauk \
  fonts-sil-abyssinica \
  fonts-lohit-deva-nepali \
  fonts-deva \
  fonts-taml \
  fonts-noto-color-emoji \
  fonts-guru \
  fonts-gujr \
  fonts-yrsa-rasa \
  fonts-beng-extra \
  fonts-liberation \
  graphviz \
  xvfb \
  libatk1.0-dev \
  libatk-bridge2.0-dev \
  libatspi2.0-dev \
  libcups2-dev \
  libxcomposite-dev \
  libxdamage-dev \
  libunwind-dev \
  libdw-dev \
  libgmp-dev \
  libgraphene-1.0-dev \
  libgsl-dev \
  libglib2.0-dev \
  libges-1.0-dev \
  libcap-dev \
  libgirepository1.0-dev \
  liborc-0.4-dev \
  libgl-dev \
  libgles-dev \
  libdrm-dev \
  libgudev-1.0-dev \
  libgbm-dev \
  libpng-dev \
  libjpeg-dev \
  libogg-dev \
  libopus-dev \
  libpango1.0-dev \
  libpangocairo-1.0-0 \
  libcairo2-dev \
  libvisual-0.4-dev \
  libtheora-dev \
  libvorbis-dev \
  libxkbcommon-dev \
  libepoxy-dev \
  libgcrypt20-dev \
  libwebp-dev \
  libopenjp2-7-dev \
  libwoff-dev \
  libxslt1-dev \
  libseccomp-dev \
  libsoup2.4-dev \
  libvulkan-dev \
  libass-dev \
  libchromaprint-dev \
  libcurl4-gnutls-dev \
  libaom-dev \
  libbz2-dev \
  liblcms2-dev \
  libbs2b-dev \
  libdca-dev \
  libfaac-dev \
  libfaad-dev \
  flite1-dev \
  libssl-dev \
  libfdk-aac-dev \
  libfluidsynth-dev \
  libgsm1-dev \
  libkate-dev \
  libgme-dev \
  libde265-dev \
  liblilv-dev \
  libmodplug-dev \
  libmjpegtools-dev \
  libmpcdec-dev \
  libdvdnav-dev \
  libdvdread-dev \
  librsvg2-dev \
  librtmp-dev \
  libsbc-dev \
  libsndfile1-dev \
  libsoundtouch-dev \
  libspandsp-dev \
  libsrt-gnutls-dev \
  libsrtp2-dev \
  libvo-aacenc-dev \
  libvo-amrwbenc-dev \
  libwebrtc-audio-processing-dev \
  libofa0-dev \
  libzvbi-dev \
  libopenexr-dev \
  libwildmidi-dev \
  libx265-dev \
  libzbar-dev \
  libaa1-dev \
  libmp3lame-dev \
  libcaca-dev \
  libdv4-dev \
  libmpg123-dev \
  libvpx-dev \
  libtag1-dev \
  libtwolame-dev \
  libwavpack-dev \
  liba52-0.7.4-dev \
  libx264-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libmpeg2-4-dev \
  libavcodec-dev \
  libavfilter-dev \
  libavformat-dev \
  libavutil-dev \
  libva-dev \
  libudev-dev \
  libsoup-3.0-dev \
  libwoff1 \
  libwebp7 \
  libegl1-mesa-dev \
  libcairo2 \
  libfontconfig1 \
  libfreetype6 \
  libcairo2-dev \
  libgnutls28-dev \
  libharfbuzz-dev \
  libicu-dev \
  libxml2-dev

libs=(
  zlib1g-dev libglib2.0-dev libffi-dev libssl-dev
  # plugins dependencies: soundtouch, opencv, nvcodec, vaapi
  libsndfile1 libsoundtouch1 libopencv-dev libegl1 libgles-dev
  # X-org dependencies
  libx11-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev
  libxrandr-dev libxcomposite-dev libxcursor-dev libxinerama-dev libxv-dev
  libxkbcommon-dev libxkbcommon-x11-dev xserver-xorg-video-dummy
  # dlib additionals
  libopenblas-base libopenblas-dev liblapack-dev libdlib-data
  # for plugin scanner
  libpython3.10
  # for CGO
  libunwind-dev libdw-dev
  # minimize build by providing dev libraries
  zlib1g-dev libglib2.0-dev libffi-dev libssl-dev
  # plugins dependencies: soundtouch
  libsndfile1-dev libsoundtouch-dev libvpx-dev
  # plugin dependencies: pango
  libpango1.0-dev libpangocairo-1.0-0 libcairo2-dev
  # plugin dependencies: vaapi
  libva-dev
  # plugin dependencies: ges
  libges-1.0-dev
)

apt-get install -y --no-install-recommends "${libs[@]}"

# Wayland dependencies
# RUN apt-get update && apt-get install -y libwayland-dev libwayland-egl-backend-dev libwayland-cursor-dev libwayland-egl1-mesa libwayland-client0 libwayland-server0

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
