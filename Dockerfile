FROM docker.io/rockylinux/rockylinux:9.3

LABEL maintainer="Dimitri Tarassenko <mitka@mitka.us>"

# FFMPEG and a few fonts, TSDuck, then clean up
RUN dnf -y install 'dnf-command(config-manager)'; \
    dnf config-manager --set-enabled crb; \
    dnf -y install --nogpgcheck \
        epel-release \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm \
        https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm; \
    dnf -y install \
        dejavu-sans-mono-fonts \
        https://github.com/tsduck/tsduck/releases/download/v3.37-3670/tsduck-3.37-3670.el9.x86_64.rpm \
        ffmpeg \
        https://github.com/m1tk4/video-gadgets/releases/download/v1.4.1/video-gadgets-1.4.1.noarch.rpm \
        https://github.com/m1tk4/mistserver/releases/download/v3.3.1/mistserver-3.3-2c6c2c09.el9.x86_64.rpm \
        https://github.com/m1tk4/mistserver/releases/download/v3.3.1/mistserver-in-av-3.3-2c6c2c09.el9.x86_64.rpm; \
    dnf clean all

# Tune-ups, clean up
RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Testing daemons
# RUN dnf -y install openssh-server; systemctl enable sshd.service

# Configure systemd: disable various systemd entries that trigger SELinux or start things that are not needed
RUN systemctl mask \
        systemd-logind.service \
        pam-auth-update \
        console-getty \
        system-getty.slice \
        dnf-makecache.timer \
        nis-domainname \
        systemd-initctl.socket \
        pcscd.socket; \
    systemctl set-default multi-user.target

# Ensure the termination happens on container stop, cgroup, starting init
STOPSIGNAL SIGRTMIN+3
CMD ["/usr/sbin/init"]
