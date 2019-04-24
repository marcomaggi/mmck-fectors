dnl mmux-chicken-check-library.m4 --
dnl
dnl Checks if a CHICKEN library is available on the system.

dnl Set the shell variable "chicken_cv_schemelib_$1" to "yes" or "no".
dnl
dnl 1 OUTPUT_VARIABLE_COMPONENT_NAME
dnl 2 LIBRARY_IMPORT_SPEC
dnl
dnl Usage example:
dnl
dnl   CHICKEN_CHECK_LIBRARY([MMUX_CHECKS],[mmux.checks])
dnl   AS_IF([test "$chicken_cv_schemelib_MMUX_CHECKS" = no],
dnl     [AC_MSG_ERROR([MMUX CHICKEN Checks not available],1)])
dnl
AC_DEFUN([MMUX_CHICKEN_CHECK_LIBRARY],
  [AC_REQUIRE([MMUX_CHICKEN_SCHEME])
   AC_CACHE_CHECK([availability of CHICKEN library $2],
     [chicken_cv_schemelib_$1],
     [AS_IF(["$CHICKEN_INTERPRETER" -q -R '$2' -eval '(exit)'],
        [AS_VAR_SET([chicken_cv_schemelib_$1],[yes])],
        [AS_VAR_SET([chicken_cv_schemelib_$1],[no])])])])

dnl end of file
dnl Local Variables:
dnl mode: autoconf
dnl End:
