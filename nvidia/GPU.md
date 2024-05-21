## Hardware accelerated encoding and compositing test on GCP

Create an Ubuntu 22.04 GPU instance. e.g.

```
export GCP_GPU_MACHINE_ZONE=us-west2-b
export GCP_GPU_MACHINE_NAME=<name>
export GCP_GPU_ADDRESS=<machine ip>

alias gpu-vm-create="gcloud compute instances create ${GCP_GPU_MACHINE_NAME} \
  --network-tier=STANDARD \
  --address=${GCP_GPU_ADDRESS} \
  --enable-nested-virtualization \
  --image-project=ubuntu-os-cloud \
  --image-family=ubuntu-2204-lts \
  --machine-type=n1-standard-8 \
  --accelerator=count=1,type=nvidia-tesla-p4 \
  --boot-disk-type=pd-ssd \
  --boot-disk-size=128GB \
  --labels=local-dev=1 \
  --tags local-dev \
  --metadata=enable-oslogin=TRUE \
  --zone ${GCP_GPU_MACHINE_ZONE} \
  --project <project-name> \
  --maintenance-policy TERMINATE --restart-on-failure"

  $> gpu-vm-create

```

### Host Machine 

- Install docker
- ./scripts/install-build-deps.sh && ./scripts/install-dependencies.sh
- sudo reboot
- docker run -it --rm --gpus all ubuntu nvidia-smi
- - You should see GPU information printed to the console.
- sudo nvidia-xconfig
- docker build -f Dockerfile.dev -t ubuntu22.04-gstreamer1.22.2 .
- sudo Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./xserver.log vt1 :1 &
- docker run --gpus all -v /usr/local/cuda:/usr/local/cuda  --device=/dev/dri/card0 --rm -e DISPLAY=$DISPLAY -v /tmp/X11-unix:/tmp/.X11 -it ubuntu22.04-gstreamer1.22.0:latest /bin/bash

### Inside the container

- Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./xserver.log vt1 :1 &
- GST_PLUGIN_PATH=Release:$GST_PLUGIN_PATH gst-launch-1.0 -e     cefsrc url="chrome://gpu" gpu=true chrome-extra-flags="use-gl=egl, enable-gpu-rasterization,ignore-gpu-blocklist" !     video/x-raw, width=1920, height=8080, framerate=1/1 !     cefdemux name=demux ! queue ! videoconvert ! pngenc !     multifilesink location="frame%d.png"
- After around 5 seconds CTRL-C

The last command will dump a series of images of the GPU page in chrome. Check to make sure HW acceleration is enabled.