#!/bin/bash
set -e

# We should put these files somewhere rather than downloading from restream.io's archives
# https://restream-archive.s3.eu-west-1.amazonaws.com/cef/cef_binary_106.1.1%2Bg5891c70%2Bchromium-106.0.5249.119_linux64.tar.bz2.sha1
# https://restream-archive.s3.eu-west-1.amazonaws.com/cef/cef_binary_106.1.1%2Bg5891c70%2Bchromium-106.0.5249.119_linux64.tar.bz2

export CEF_DOWNLOAD_URL=
export CEF_VERSION=117.0.10+gfb73900+chromium-117.0.5938.48

GST_CEF_BUILD_TYPE=Release

pushd plugins/gstcefsrc 
# rm -rf build
rm -rf lib
# rm -rf third_party/cef

if [[ -z "${PLUGIN_DEV}" ]]; then
  GST_CEF_CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=/opt/gstreamer/lib/$(uname -m)-linux-gnu/gstreamer-1.0/cef -GNinja -DCEF_BUILDS_HOMEPAGE_URL=$CEF_DOWNLOAD_URL -DCEF_VERSION=$CEF_VERSION"
  cmake $GST_CEF_CMAKE_OPTS -DCMAKE_BUILD_TYPE=$GST_CEF_BUILD_TYPE -B build -S .
else
  GST_CEF_CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=$PWD/lib -GNinja -DCEF_BUILDS_HOMEPAGE_URL=$CEF_DOWNLOAD_URL -DCEF_VERSION=$CEF_VERSION"
  cmake $GST_CEF_CMAKE_OPTS -DCMAKE_BUILD_TYPE=$GST_CEF_BUILD_TYPE -B build -S .
fi

ninja -C build install
popd

if [ "${#dev}" -gt 0 ]; then
  exit 0
fi