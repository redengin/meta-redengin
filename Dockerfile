# using the smallest crops image
FROM crops/yocto:ubuntu-20.04-builder AS base
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
ENV PATH="/opt/poky/bitbake/bin:/opt/poky/scripts:$PATH"
USER yoctouser

ENTRYPOINT ["/usr/local/bin/distro-entry.sh", \
            "/usr/bin/dumb-init"]

# create a toaster image
FROM base AS toaster
USER root
RUN pip3 install -r /opt/poky/bitbake/toaster-requirements.txt
USER yoctouser
CMD sh -c ". /opt/poky/bitbake/bin/toaster start webport=0.0.0.0:8000; sleep infinity"