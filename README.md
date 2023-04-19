# OpenLens Building Utilities

This repository contains Docker compose configurations that can be used to
build the latest version of OpenLens from the source.  

Utilizing containers, these compose configurations will generate packages or
installers for the latest version of OpenLens directly from the sources.

This repository *does not* contain source code from OpenLens.  All OpenLens
assets and code are pulled directly from their own repository.

## Prerequisites

To build Linux deb, rpm, or AppImages, you'll need to set up Docker with the 
Docker Compose plugin.  Docker can also be used to build a Windows setup
binary.

To build a Mac OS DMG, you will need:

* Homebrew
* XCode from the Apple Store on a Mac (building Mac versions is not supported 
  from any operating system but MacOS).
* `jq`, which can be installed from Homebrew

Additionally, you'll need all the prerequisites of OpenLens, which are
(as of the time of writing):

* NodeJS 16
* Yarn

## Building Linux Packages

To build rpms, use the `rpm-linux-builder` service defined in the
`docker-compose.yml` file.  The container should build, run the OpenLens build
process, copy the resulting rpms to `distout`, and finish.

```
$ docker compose up rpm-linux-builder
```

To build debs and AppImage binaries, use the `deb-linux-builder` service
defined in the `docker-compose.yml` file. The container should build, run the
OpenLens build process, copy the resulting debs and AppImages to `distout` and
finish.

```
$ docker compose up deb-linux-builder
```

## Building Windows Packages

To build a setup binary for Windows, you can use the `win-builder` service
defined in the `docker-compose.yml` file.  The container should build, run the
OpenLens build process, copy the requlting setup binary (`exe`) to `distout`
and finish.

```
$ docker compose up win-builder
```

Note: The Windows builder makes a change to the `ensure-binaries` library
included with the lens source code.  It forces the `ensure-binaries` to assume
the platform is `win32`, since we're technically building in a Linux container.

## Building Mac DMGs

To build a DMG installer for Mac, make sure you've met the prerequisites listed
above, then run `mac_build.sh`.

## Cleanup

To cleanup your environment, remove all `AppImage`, `deb`, `rpm`, `exe` and
`dmg` files from `distout`, then down all Docker Compose services defined in
the file to remove your containers and images.

```
$ docker compose down --rmi all -v 
```

For further cleanup, you might want to remove any hanging images in Docker via
the `system prune` command.

```
$ docker system prune
```
