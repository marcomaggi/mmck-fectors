#!/bin/bash
#
# Installation  script to  run from  the  Travis CI  config file  before
# attempting a build.
#
# Install the CHICKEN egg "coops"  under the directory "/usr/local".  We
# assume the script is run from the top directory of the build tree.

PROGNAME=${0##*/}

prefix=/usr/local
if test -d /lib64
then libdir=${prefix}/lib64
else libdir=${prefix}/lib
fi

if test "$TRAVIS_OS_NAME" = osx
then THE_PLATFORM=macosx
else THE_PLATFORM=linux
fi

function main () {
    (umask 0; sudo chicken-install coops)
}

function script_error () {
    local TEMPLATE="${1:?missing template argument to '$FUNCNAME'}"
    shift
    {
	printf '%s: ' "$PROGNAME"
	printf "$TEMPLATE" "$@"
	printf '\n'
    } >&2
    exit 1
}

main "$@"

### end of file
