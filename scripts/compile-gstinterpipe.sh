#!/bin/bash
set -e

pushd plugins/gst-interpipe
rm -rf build
rm -rf lib
mkdir build

if [[ -z "${PLUGIN_DEV}" ]]; then
  # meson build --prefix /opt/gstreamer --libdir /opt/gstreamer/lib/$(uname -m)-linux-gnu/
  meson build --prefix /opt/gstreamer --libdir /opt/gstreamer/lib/$(uname -m)-linux-gnu/
else
  meson build --prefix $PWD/lib --libdir=$PWD/lib --buildtype=release
fi

ninja -C build
ninja -C build install
popd
