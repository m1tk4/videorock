FROM rockylinux/rockylinux:8

LABEL maintainer="Dimitri Tarassenko <mitka@mitka.us>"

ENV container=docker

# Systemd - specific stuff
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# FFMPEG and a few fonts, TSDuck, then clean up
RUN dnf -y install --nogpgcheck dnf-plugins-core https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
        https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm; \
    dnf -y config-manager --enable powertools; \
    dnf -y install dejavu-sans-mono-fonts \
        https://github.com/tsduck/tsduck/releases/download/v3.29-2651/tsduck-3.29-2651.el8.x86_64.rpm; \
    dnf -y install https://github.com/m1tk4/video-gadgets/releases/download/v1.0.0/video-gadgets-1.0.0.noarch.rpm; \
    dnf install -y \
        https://github.com/m1tk4/ffmpeg-rpm/releases/download/latest/ffmpeg-5.0.0.x86_64.rpm \
        https://github.com/m1tk4/ffmpeg-rpm/releases/download/latest/ffmpeg-libs-5.0.0.x86_64.rpm \ 
        https://github.com/m1tk4/ffmpeg-rpm/releases/download/latest/libavdevice-5.0.0.x86_64.rpm \
        https://github.com/m1tk4/ffmpeg-rpm/releases/download/latest/ffmpeg-tools-5.0.0.x86_64.rpm; \
    dnf -y update; \
    dnf clean all

# Tune-ups, clean up
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Ensure the termination happens on container stop, cgroup, starting init
STOPSIGNAL SIGRTMIN+3 
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
