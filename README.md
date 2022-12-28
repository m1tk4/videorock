# videorock
[![Docker Image CI](https://github.com/m1tk4/videorock/actions/workflows/docker-image.yml/badge.svg)](https://github.com/m1tk4/videorock/actions/workflows/docker-image.yml)

Rocky Linux 9 container with systemd wrapper and a collection of video related tools:

- [ffMPEG](https:/ffmpeg.org)
- monospaced DejaVu fonts
- [MistServer](https://www.mistserver.org)
- [TSDuck](https://tsduck.io)

## Usage

This image is useful as a base building block for other containers. Add

```dockerfile
FROM ghcr.io/m1tk4/videorock:latest
```

at the top of your `Dockerfile` to build on top of this.

Note that `:latest` is the last **tagged release**, not the last commit in Github repo. To
get the last available version, use:

```dockerfile
FROM ghcr.io/m1tk4/videorock:main
```

Starting from version 9 the containers are using the latest Rocky 9.x release. If you need a specific Rocky release here is the reference:

| Rocky Release | videorock Release |
|---------------|-------------------|
|9.1|9.1.x|
|8.5|2.3|


