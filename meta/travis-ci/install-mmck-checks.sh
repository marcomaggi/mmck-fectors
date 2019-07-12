#!/bin/bash
#
# Installation  script to  run from  the  Travis CI  config file  before
# attempting a build.
#
# Install MMCK Checks  under the directory "/usr/local".   We assume the
# script is run from the top directory of the build tree.

PROGNAME=${0##*/}
PACKAGE_NAME=mmck-checks
REQUIRED_PACKAGE_VERSION=0.3.0-devel.0
STEM=${PACKAGE_NAME}-${REQUIRED_PACKAGE_VERSION}
VERSION_EXECUTABLE=$PACKAGE_NAME
ARCHIVE=${STEM}.tar.gz
SOURCE_URI="https://github.com/marcomaggi/${PACKAGE_NAME}/archive/v${REQUIRED_PACKAGE_VERSION}.tar.gz"
LOCAL_ARCHIVE=/tmp/${ARCHIVE}
TOP_SRCDIR=/tmp/${STEM}
prefix=/usr/local

if test -d /lib64
then libdir=${prefix}/lib64
else libdir=${prefix}/lib
fi

#CHICKEN_VERSION=$(csi -release)
export CHICKEN_REPOSITORY_PATH=$(csi -R chicken.platform -e '(map (lambda (P) (display P)(display ":")) (repository-path))(newline)')

function main () {
    script_verbose 'wget "%s" --no-check-certificate -O "%s"' "$SOURCE_URI" "$LOCAL_ARCHIVE"
    if ! wget --no-check-certificate "$SOURCE_URI" -O "$LOCAL_ARCHIVE"
    then script_error 'error downloading %s' "$ARCHIVE"
    fi

    cd /tmp

    script_verbose 'tar --extract --gzip --file="%s"' "$LOCAL_ARCHIVE"
    if ! tar --extract --gzip --file="$LOCAL_ARCHIVE"
    then script_error 'error unpacking %s' "$LOCAL_ARCHIVE"
    fi

    cd "$TOP_SRCDIR"

    script_verbose 'sh autogen.sh'
    if ! sh autogen.sh
    then script_error 'error generating configuration %s' "$STEM"
    fi

    script_verbose './configure --prefix="%s" --enable-maintainer-mode' "$prefix"
    if ! ./configure --prefix="$prefix" --libdir="$libdir" --enable-maintainer-mode
    then script_error 'error configuring %s' "$STEM"
    fi

    script_verbose 'make -j2 all'
    if ! make -j2 all
    then script_error 'error building all %s' "$STEM"
    fi

    script_verbose '(umask 0; sudo make install)'
    if ! (umask 0; sudo make install)
    then script_error 'error installing %s' "$STEM"
    fi

    exit 0
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

function script_verbose () {
    local TEMPLATE="${1:?missing template argument to '$FUNCNAME'}"
    shift
    {
	printf '%s: command: ' "$PROGNAME"
	printf "$TEMPLATE" "$@"
	printf '\n'
    } >&2
}

main "$@"

### end of file
