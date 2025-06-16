# using the smallest crops image
FROM crops/yocto:ubuntu-20.04-builder
# provide the path to the crops image's user directory
ARG HOME=/home/yoctouser

# Install yocto/bitbake
# use LTS https://wiki.yoctoproject.org/wiki/Releases
ARG POKY_VERSION=scarthgap
USER root
RUN cd /opt \
 && git clone --depth=1 \
        --single-branch --branch ${POKY_VERSION} \
        git://git.yoctoproject.org/poky
ENV PATH="/opt/poky/bitbake/bin:$PATH"
USER yoctouser

ENTRYPOINT ["/usr/local/bin/distro-entry.sh", \
            "/usr/bin/dumb-init"]


