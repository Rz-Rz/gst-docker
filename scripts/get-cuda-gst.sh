#!/bin/bash
set -e

mkdir -p deps
cd deps

echo "Cloning GStreamer"
git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git
cd gstreamer
git checkout 1.22.2
cd ../..

echo "Downloading opencv"

curl https://github.com/opencv/opencv/archive/refs/tags/4.7.0.zip -L --output deps/opencv.zip
curl https://github.com/opencv/opencv_contrib/archive/refs/tags/4.7.0.zip -L --output deps/opencv_contrib.zip

echo "Downloading dlib"

curl http://dlib.net/files/dlib-19.24.tar.bz2 --output deps/dlib.tar.bz2

echo "Downloading nvrtc"

wget -P deps/ https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-nvrtc-dev-12-1_12.1.55-1_amd64.deb
wget -P deps/ https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-nvrtc-12-1_12.1.55-1_amd64.deb

