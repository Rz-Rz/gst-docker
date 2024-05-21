#!/bin/bash
set -e

pushd plugins/gst-perf
./autogen.sh

if [[ -z "${PLUGIN_DEV}" ]]; then
  # ./configure --prefix /opt/gstreamer --libdir /opt/gstreamer/lib/$(uname -m)-linux-gnu/
  ./configure --prefix /opt/gstreamer --libdir /opt/gstreamer/lib/$(uname -m)-linux-gnu/
else
  ./configure --prefix $PWD/lib --libdir $PWD/lib
fi

make
make install
popd