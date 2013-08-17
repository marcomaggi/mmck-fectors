dnl @configure_input@
dnl

AC_PREREQ([2.69])
AC_INIT([Fectors],[0.2a0],[marco.maggi-ipsu@poste.it],
  [fectors],[https://github.com/marcomaggi/fectors])
AC_CONFIG_SRCDIR([lib])
AC_CONFIG_MACRO_DIR([autotools])
AC_CONFIG_AUX_DIR([autotools])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([-Wall foreign dist-xz no-dist-gzip])
AM_MAINTAINER_MODE

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P

VICARE_SCHEME
VICARE_OPTION_DEBUGGING_MODE
AM_CONDITIONAL([WANT_VICARE_DEBUG],[test x$VICARE_DEBUG = xyes])
AM_COND_IF([WANT_VICARE_DEBUG],[AS_VAR_SET(VFLAGS,"$VFLAGS -g")])

dnl page
dnl Optional features

AC_MSG_CHECKING([whether to enable timing of tests])
AC_ARG_ENABLE([time-tests],
  [AS_HELP_STRING([--enable-time-tests],[enable support for Vicare Scheme (default: no)])],
  [if test x$withval = xyes
   then fectors_time_tests=yes
   else fectors_time_tests=no
   fi],
  [fectors_time_tests=no])
AC_MSG_RESULT([$fectors_time_tests])
AM_CONDITIONAL([WANT_TIME_TESTS],[test x$fectors_time_tests = xyes])
AM_COND_IF([WANT_TIME_TESTS],
  [AC_CHECK_PROG([TIME_PROGRAM],[time],[time],[:])])

dnl page
dnl done

VICARE_OUTPUT
AC_CONFIG_FILES([Makefile]
  [tests/Makefile]
  [doc/Makefile]
  [lib/Makefile]
  [meta/slackware/doinst.sh])
AC_OUTPUT

dnl end of file
