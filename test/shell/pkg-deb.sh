#!/bin/bash

# test debian package

# build a release for testing


docker run -ti --rm -v $PWD/releases:/releases debian:18.04 /bin/sh -c "\
	apt update; \
        apt install -yqq /releases/
