# @configure_input@
#

AC_PREREQ([2.69])
MMUX_PKG_VERSIONS([0],[5],[0],[devel.2])
AC_INIT([MMCK Fectors],[MMUX_PACKAGE_VERSION],
  [mrc.mgg@gmail.com],
  [mmck-fectors],[http://github.com/marcomaggi/mmck-fectors])
MMUX_INIT
AC_REVISION([0.1])
AC_COPYRIGHT([Copyright (c) 2019 Marco Maggi <mrc.mgg@gmail.com>
Copyright (C) 2012 Ian Price <ianprice90@googlemail.com>
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
])
AC_CONFIG_SRCDIR([lib/])
AC_CONFIG_MACRO_DIR([meta/autotools])
AC_CONFIG_AUX_DIR([meta/autotools])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([1.16 foreign subdir-objects])
AM_MAINTAINER_MODE

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P


#### basic system inspection

MMUX_CHECK_TARGET_OS
AX_IS_RELEASE([git-directory])

AC_CACHE_SAVE


#### external libraries

MMUX_CHICKEN_SCHEME
MMUX_CHICKEN_CHECK_LIBRARY([COOPS],[coops])
MMUX_CHICKEN_CHECK_LIBRARY([COOPS_PRIMITIVE_OBJECTS],[coops-primitive-objects])
MMUX_CHICKEN_CHECK_LIBRARY([MMCK_CHECKS],[mmck.checks])

AM_CONDITIONAL([MMCK_TESTING_ENABLED],[test "x$chicken_cv_schemelib_MMCK_CHECKS" = xyes])

AC_CACHE_SAVE


#### finish

AC_CONFIG_FILES([Makefile]
   [lib/config.scm])
MMUX_OUTPUT
AC_OUTPUT

### end of file
