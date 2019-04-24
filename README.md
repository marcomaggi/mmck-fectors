# MMCK Fectors

[![Build Status](https://travis-ci.org/marcomaggi/mmck-fectors.svg?branch=master)](https://travis-ci.org/marcomaggi/mmck-fectors)

## Introduction

This project builds and installs  a CHICKEN language libraries.  CHICKEN
is a Scheme-to-C compiler supporting the language features as defined in
the ``Revised^5 Report on Scheme''.

Functional  programming needs  functional data  structures.  This  is an
implementation of "vectors" (also called  arrays), a finite map keyed by
consecutive  integers between  0  and n-1,  n being  the  length of  the
vector.  Being functional, the structure  is not observably mutable, and
so access to any version will always give the correct answer.

There are  many possible  implementations of  the vector  interface with
different  efficiency  characteristics,  the one  contained  prioritises
"single threaded" use  of vectors, that is, one in  which access is most
frequently  to  the last  created  version  of  the vector.   Access  to
previously stored versions works correctly,  though it will not be quite
as efficient.

The library  targets POSIX systems.   The code depends on  the extension
`coops`.  To run  the tests: this package depends upon  the package MMCK
Checks.

The package uses the GNU Autotools and it is tested, using Travis CI, on
both Ubuntu GNU+Linux  systems and OS X systems.  The  package relies on
`pkg-config` to find the dependencies installed on the system.

The last time  the maintainer bothered to update this  paragraph: he had
tested CHICKEN 5.0.0.

## License

Copyright (c) 2012, 2019 Marco Maggi `marco.maggi-ipsu@poste.it`<br/>
Copyright (c) 2012 Ian Price `ianprice90@googlemail.com`<br/>
All rights reserved.

Redistribution  and use  in source  and  binary forms,  with or  without
modification, are  permitted provided that the  following conditions are
met:

1.  Redistributions  of source  code  must  retain the  above  copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions  in binary  form must  reproduce the  above copyright
   notice, this list  of conditions and the following  disclaimer in the
   documentation and/or other materials provided with the distribution.

3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE  IS PROVIDED BY  THE AUTHOR ``AS  IS'' AND ANY  EXPRESS OR
IMPLIED  WARRANTIES,   INCLUDING,  BUT  NOT  LIMITED   TO,  THE  IMPLIED
WARRANTIES OF MERCHANTABILITY  AND FITNESS FOR A  PARTICULAR PURPOSE ARE
DISCLAIMED.  IN  NO EVENT  SHALL THE  AUTHOR BE  LIABLE FOR  ANY DIRECT,
INDIRECT,  INCIDENTAL,  SPECIAL,  EXEMPLARY,  OR  CONSEQUENTIAL  DAMAGES
(INCLUDING,  BUT NOT  LIMITED  TO, PROCUREMENT  OF  SUBSTITUTE GOODS  OR
SERVICES;  LOSS OF  USE,  DATA, OR  PROFITS;  OR BUSINESS  INTERRUPTION)
HOWEVER  CAUSED AND  ON ANY  THEORY OF  LIABILITY, WHETHER  IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
ANY  WAY OUT  OF  THE USE  OF  THIS  SOFTWARE, EVEN  IF  ADVISED OF  THE
POSSIBILITY OF SUCH DAMAGE.

## Install

To install from a proper release tarball, do this:

```
$ cd mmck-fectors-0.1.0
$ mkdir build
$ cd build
$ ../configure
$ make
$ make check
$ make install
```

to inspect the available configuration options:

```
$ ../configure --help
```

The Makefile is designed to allow parallel builds, so we can do:

```
$ make -j4 all && make -j4 check
```

which,  on  a  4-core  CPU,   should  speed  up  building  and  checking
significantly.

The Makefile supports the DESTDIR  environment variable to install files
in a temporary location, example: to see what will happen:

```
$ make -n install DESTDIR=/tmp/mmck-fectors
```

to really do it:

```
$ make install DESTDIR=/tmp/mmck-fectors
```

After the  installation it is  possible to verify the  installed library
against the test suite with:

```
$ make installcheck
```

From a repository checkout or snapshot  (the ones from the Github site):
we  must install  the GNU  Autotools  (GNU Automake,  GNU Autoconf,  GNU
Libtool), then  we must first run  the script `autogen.sh` from  the top
source directory, to generate the needed files:

```
$ cd mmck-fectors
$ sh autogen.sh

```

After this  the procedure  is the same  as the one  for building  from a
proper release tarball, but we have to enable maintainer mode:

```
$ ../configure --enable-maintainer-mode [options]
$ make
$ make check
$ make install
```

When compiling  the environment  variable CHICKEN_FLAGS is  available to
hand options to the compiler:

```
$ make CHICKEN_FLAGS='-d3'
```

Shared libraries will be installed under:

```
${libdir}/chicken/9
```

## Usage

Read the documentation generated from  the Texinfo sources.  The package
installs the documentation  in Info format; we can  generate and install
documentation in HTML format by running:

```
$ make html
$ make install-html
```

## Credits

The original  code base is  the `fectors` project  by Ian Price;  it was
ported first to Vicare Scheme by  Marco Maggi; then ported to CHICKEN by
Marco  Maggi.  If  this package  exists it's  because of  the great  GNU
software tools  that he  uses all  the time.   CHICKEN was  originally a
creation of Felix L.  Winkelmann, it is now developed and maintained The
CHICKEN Team.

## Bugs, vulnerabilities and contributions

Bug  and vulnerability  reports are  appreciated, all  the vulnerability
reports  are  public; register  them  using  the  Issue Tracker  at  the
project's GitHub  site.  For  contributions and  patches please  use the
Pull Requests feature at the project's GitHub site.

## Resources

The latest release of this package can be downloaded from:

[https://bitbucket.org/marcomaggi/mmck-fectors/downloads](https://bitbucket.org/marcomaggi/mmck-fectors/downloads)

development takes place at:

[http://github.com/marcomaggi/mmck-fectors/](http://github.com/marcomaggi/mmck-fectors/)

and as backup at:

[https://bitbucket.org/marcomaggi/mmck-fectors/](https://bitbucket.org/marcomaggi/mmck-fectors/)

the documentation is available online:

[http://marcomaggi.github.io/docs/mmck-fectors.html](http://marcomaggi.github.io/docs/mmck-fectors.html)

the GNU Project software can be found here:

[http://www.gnu.org/](http://www.gnu.org/)

we can download CHICKEN from:

[http://www.call-cc.org/](http://www.call-cc.org/)

the package MMCK Checks is available from:

[https://github.com/marcomaggi/mmck-checks/](https://github.com/marcomaggi/mmck-checks/)

the original implementation of fectors is at:

[https://github.com/ijp/fectors](https://github.com/ijp/fectors)

## Badges and static analysis

### Travis CI

Travis CI is  a hosted, distributed continuous  integration service used
to build and test software projects  hosted at GitHub.  We can find this
project's dashboard at:

[https://travis-ci.org/marcomaggi/mmck-fectors](https://travis-ci.org/marcomaggi/mmck-fectors)

Usage of this  service is configured through the  file `.travis.yml` and
additional scripts are under the directory `meta/travis-ci`.

