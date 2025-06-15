# using the smallest crops image
FROM crops/yocto:ubuntu-20.04-builder
# provide the path to the crops image's user directory
ARG HOME=/home/yoctouser

# install yocto
# use LTS https://wiki.yoctoproject.org/wiki/Releases
ARG POKY_VERSION=scarthgap
RUN cd $HOME \
 && git clone --depth=1 \
        --single-branch --branch ${POKY_VERSION} \
        git://git.yoctoproject.org/poky
ENV POKY_DIR=${HOME}/poky
ENV BUILD_DIR=${HOME}/build