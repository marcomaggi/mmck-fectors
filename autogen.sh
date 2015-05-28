# autogen.sh --
#
# Run this in the top source directory to rebuild the infrastructure.

LIBTOOLIZE=${LIBTOOLIZE:=libtoolize}

set -xe
test -d meta/autotools			|| mkdir meta/autotools
autoreconf --warnings=all --install --verbose "$@"

### end of file
