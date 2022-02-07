# videorock
[![Docker Image CI](https://github.com/m1tk4/videorock/actions/workflows/docker-image.yml/badge.svg)](https://github.com/m1tk4/videorock/actions/workflows/docker-image.yml)

Rocky Linux container with systemd wrapper and a collection of video related tools:

- ffMPEG
- monospaced DejaVu fonts
- TSDuck

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
