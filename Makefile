# introspect user to create DOCKER_USER
DOCKER_USER ?= $$(id -u):$$(id -g)

# bitbake configuration
BITBAKE_DISTRO ?= redengin
BITBAKE_MACHINE ?= qemux86-64

.PHONY: shell
shell:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose run --rm --remove-orphans crops \
			sh

.PHONY: bitbake
RECIPE ?= core-image-minimal
bitbake:
	@DOCKER_USER=${DOCKER_USER} \
		docker compose run --rm --remove-orphans crops \
			sh -c "BB_ENV_PASSTHROUGH_ADDITIONS='DISTRO MACHINE' \
				   DISTRO=${BITBAKE_DISTRO} \
				   MACHINE=${BITBAKE_MACHINE} \
				bitbake ${RECIPE} --dry-run"
