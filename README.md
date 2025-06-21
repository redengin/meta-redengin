Yocto Build environment and my personal recipes
================================================================================

Yocto Build Environment
--------------------------------------------------------------------------------
Docker images have been defined for all the tools necessary.

The [Makefile](Makefile) provides easy access to the yocto build environment
(see comments for further customization options).

### Shell
Allows the user to use yocto/bitbake commands manually.
```sh
make shell
```

### Bitbake
Allows the user to use bitbake recipes.
```sh
[DISTRO=...] [MACHINE=...] RECIPE=... make bitbake
```

DISTRO(optional)
: choose the distribution to use

MACHINE(optional)
: choose the machine to build for

RECIPE
: recipe/image to build


### Run image under QEMU
Boots the latest image build, using KVM.
```
make runqemu
```

### Toaster
Provides a web interface to configure and build images.
```
make toaster
```
