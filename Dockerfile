# using the smallest crops image
FROM crops/yocto:ubuntu-20.04-builder

# install yocto
# use LTS https://wiki.yoctoproject.org/wiki/Releases
ARG HOME=/home/yoctouser
RUN cd $HOME \
 && git clone --depth=1 --single-branch --branch scarthgap \
        git://git.yoctoproject.org/poky
ENV POKY_DIR=${HOME}/poky
ENV BUILD_DIR=${HOME}/build