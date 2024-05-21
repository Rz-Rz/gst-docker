TODO: Move plugins to their own repo, and pull them when building

The plugins have been forked due to modifications specific for our use. Occasionally one of the plugins will need to be patched, updated or modified. This is a guide to getting setup to work on them. There are build scripts for each plugin that can be used if desired.

[gstcefsrc](https://github.com/centricular/gstcefsrc) - Plugin that uses CEF (Chromium Embedded) as a source of audio and video.

- Currently this has been modified to add a flag to dump audio data unless the pipeline is in PLAYING state. This was done to prevent pipeline stalls/deadlocks when the pipeline is not in PLAYING state. See [these](https://github.com/centricular/gstcefsrc/issues/69) [issues](https://github.com/centricular/gstcefsrc/issues/59).

[gstperf](https://github.com/RidgeRun/gst-perf) - This is used to measure various performance metrics of the gstreamer pipeline.

- This has been modified to add GPU stats.

[gst-interpipe](https://github.com/RidgeRun/gst-interpipe) - This is used to connect two or more gstreamer pipelines together. See RidgeRun's [docs](https://developer.ridgerun.com/wiki/index.php/GstInterpipe_-_Interpipesrc_Detailed_Description) for more information.

##### Local or Remote machine development

When working on a local or remote machine you can simply use the compile scripts to build the plugin. If you prefix the build script with `PLUGIN_DEV` the output will be place in the `<plugin_path>/lib` directory, otherwise the scripts will attempt to place the libs in `/opt/gstreamer`. Then setup your `GST_PLUGIN_PATH` to point to the `<plugin_path>/lib` directory. For example:

```bash
./scripts/build-perf.sh
export GST_PLUGIN_PATH=$PWD/gst-perf/lib
```

You should now be able to run the `gst-inspect-1.0` command and see the `perf` plugin listed. e.g. `gst-inspect-1.0 perf`

###### Docker development

Questions to be answered:

- Given the plugins are installed in `/usr/lib/x86_64-linux-gnu/gstreamer-1.0` how do we get gstreamer to use the local version?
- Will simply setting GST_PLUGIN_PATH work?
- Should we simply install the plugins to `/opt/gstreamer/..`?
- - I think the best way to do this would be to simply run the scripts without using the `PLUGIN_DEV` prefix. This will install the plugins to `/opt/gstreamer/..`. The GST_PLUGIN_PATH will not need to be modified.

Notes:

- Outline the use of GST_DEBUG and GST_DEBUG_DUMP_DOT_DIR to debug the pipeline
- Given an example workflow of how to work with the tools to build and debug a pipeline
