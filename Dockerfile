FROM rockylinux/rockylinux:9.1

LABEL maintainer="Dimitri Tarassenko <mitka@mitka.us>"

ENV container=docker

# FFMPEG and a few fonts, TSDuck, then clean up
RUN dnf -y install 'dnf-command(config-manager)'; \
    dnf config-manager --set-enabled crb; \
    dnf -y install --nogpgcheck \
        epel-release \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm \
        https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm; \
    dnf -y install \
        dejavu-sans-mono-fonts \
        https://github.com/tsduck/tsduck/releases/download/v3.32-2983/tsduck-3.32-2983.el9.x86_64.rpm \
        ffmpeg \
        https://github.com/m1tk4/video-gadgets/releases/download/v1.4.0/video-gadgets-1.4.0.noarch.rpm; \
    dnf -y update; \
    dnf clean all

# Tune-ups, clean up
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Systemd cleanup
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Ensure the termination happens on container stop, cgroup, starting init
STOPSIGNAL SIGRTMIN+3
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
