#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

mkdir /usr/share/fonts/truetype/averta
cp /fonts/*.ttf /usr/share/fonts/truetype/averta/
echo "Averta font family installed"

