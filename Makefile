# introspect user to create DOCKER_USER
DOCKER_USER ?= $$(id -u):$$(id -g)

# allow using alternative build dir (since these things are big)
BUILD_DIR ?= ./build/
BUILD_DIR = /mnt/yocto-build/

# bitbake configuration
BITBAKE_DISTRO ?= redengin
BITBAKE_MACHINE ?= qemux86-64

# use bitbake (and its utilities directly)
.PHONY: shell
shell:
	@DOCKER_USER=${DOCKER_USER} \
	 BUILD_DIR=${BUILD_DIR} \
		docker compose run --rm --remove-orphans crops \
			sh

# invoke a bitbake recipe build
# example: 'RECIPE=core-image-minimal make bitbake'
.PHONY: bitbake
RECIPE ?= core-image-minimal
bitbake:
	@DOCKER_USER=${DOCKER_USER} \
	 BUILD_DIR=${BUILD_DIR} \
		docker compose run --rm --remove-orphans crops \
			sh -c "BB_ENV_PASSTHROUGH_ADDITIONS='DISTRO MACHINE' \
				   DISTRO=${BITBAKE_DISTRO} \
				   MACHINE=${BITBAKE_MACHINE} \
				bitbake ${RECIPE}"

.PHONY: runqemu
runqemu:
	@DOCKER_USER=${DOCKER_USER} \
	 BUILD_DIR=${BUILD_DIR} \
		docker compose run --rm --remove-orphans qemu-kvm

# web interface for configuring and running builds
.PHONY: toaster
toaster:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose up toaster

.PHONY: clean
clean:
	@rm -f 	${BUILD_DIR}/bitbake-cookerdaemon.log
	@rm -f 	${BUILD_DIR}/bitbake.lock
	@rm -f 	${BUILD_DIR}/bitbake.sock
	@rm -rf ${BUILD_DIR}/buildhistory
	@rm -rf ${BUILD_DIR}/cache
	@rm -rf ${BUILD_DIR}/downloads
	@rm -f 	${BUILD_DIR}/pyshtables.py
	@rm -rf ${BUILD_DIR}/sstate-cache
	@rm -rf ${BUILD_DIR}/tmp-glibc
	@rm -rf ${BUILD_DIR}/tmp
	@rm -rf ${BUILD_DIR}/toaster_logs
