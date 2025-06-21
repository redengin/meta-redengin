# introspect user to create DOCKER_USER
DOCKER_USER ?= $$(id -u):$$(id -g)

# bitbake configuration
BITBAKE_DISTRO ?= redengin
BITBAKE_MACHINE ?= qemux86-64

# use bitbake (and its utilities directly)
.PHONY: shell
shell:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose run --rm --remove-orphans crops \
			sh

# invoke a bitbake recipe build
# example: 'RECIPE=core-image-minimal make bitbake'
.PHONY: bitbake
RECIPE ?= core-image-minimal
bitbake:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose run --rm --remove-orphans crops \
			sh -c "BB_ENV_PASSTHROUGH_ADDITIONS='DISTRO MACHINE' \
				   DISTRO=${BITBAKE_DISTRO} \
				   MACHINE=${BITBAKE_MACHINE} \
				bitbake ${RECIPE}"

# web interface for configuring and running builds
.PHONY: toaster
toaster:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose up toaster

.PHONY: runqemu
runqemu:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose run --rm --remove-orphans qemu-kvm

.PHONY: clean
clean:
	rm build/bitbake-cookerdaemon.log
	rm bitbake.lock
	rm bitbake.sock
	rm -rf buildhistory
	rm -rf cache
	rm -rf downloads
	rm pyshtables.py
	rm -rf sstate-cache
	rm -rf tmp-glibc
	rm -rf tmp
	rm -rf toaster_logs
