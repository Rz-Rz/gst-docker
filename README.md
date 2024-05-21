## Files for generate a image for GStreamer development

The Dockerfile will install:

- opencv and opencv_contrib 4.7.0 (currently disabled)
- dlib 19.24
- libnvrtc (from CUDA) 12
- Build and install [GStreamer 1.22.2](https://gitlab.freedesktop.org/gstreamer/gstreamer)
- Xorg Dummy
- Xvfb

For a full list of deps look at the Dockerfile and `scripts/install-dependencies.sh`

### **Requirements**

- Docker

### **Building**

It is recommended you use a large GCP/AWS machine when building this, or
a really good dev machine.

##### **AMD64**

```sh
docker build -f Dockerfile -t ubuntu-gstreamer:latest .
```

##### **AMD64 CI**

```sh
docker build -f Dockerfile.test -t ubuntu-gstreamer-test:latest .
```

##### **ARM64**

```sh
docker build --platform=linux/arm64 -f Dockerfile.arm64 -t ubuntu-gstreamer-arm64:latest .
```

#### **ARM64 Cross Platform**

Make sure `docker dockerx ls` lists the `arm64` architecture. If it does not then follow the setup instructions [here](https://docs.docker.com/build/building/multi-platform/). They may work for you. I have noticed that the resulting images files are huge. This may be due to buildkit, idk. 

For an ARM build on an AMD64 N1 Ubuntu 22.04LTS machine I had to do this:

```
docker pull tonistiigi/binfmt:latest
docker run --privileged --rm tonistiigi/binfmt --uninstall qemu-*
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --driver=docker-container --platform=linux/arm64 --bootstrap --name arm64
```

```
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx build --platform linux/arm64 -f Dockerfile.arm64 -t ubuntu-gstreamer-arm64:latest --load .
```
