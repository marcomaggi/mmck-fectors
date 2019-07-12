dnl mmux-chicken-scheme.m4 --
dnl
dnl Finds Chicken Scheme with compiler executable installed as "csc".

# Synopsis:
#
#    MMUX_CHICKEN_SCHEME
#
# Check the file pathanmes of the CHICKEN compiler "csc" and interpreter
# "csi"; set them, respectively, to the variables and substitutions:
#
#    CHICKEN_COMPILER
#    CHICKEN_INTERPRETER
#
# Acquire the release number of chicken and store it in the variable and
# substitution:
#
#    CHICKEN_RELEASE_NUMBER
#
# then split  it into its components  and store them into  the variables
# and substitutions:
#
#    CHICKEN_RELEASE_MAJOR
#    CHICKEN_RELEASE_MINOR
#    CHICKEN_RELEASE_PATCH
#
# Define  the  substitution   MMUX_CHICKEN_LIBDIR  to  the  installation
# directory for shared libraries.
#
AC_DEFUN([MMUX_CHICKEN_SCHEME],
  [AX_REQUIRE_DEFINED([MMUX_SPLIT_VERSION])

   AC_PATH_PROG([CHICKEN_COMPILER],[csc],[:])
   AC_PATH_PROG([CHICKEN_INTERPRETER],[csi],[:])

   AC_CACHE_CHECK([CHICKEN release number],
     [mmux_cv_chicken_release_NUMBER],
     [AS_VAR_SET(mmux_cv_chicken_release_NUMBER,[$("$CHICKEN_INTERPRETER" -release)])])
   AS_VAR_SET(CHICKEN_RELEASE_NUMBER,[$mmux_cv_chicken_release_NUMBER])
   AC_SUBST([CHICKEN_RELEASE_NUMBER],[$CHICKEN_RELEASE_NUMBER])
   MMUX_SPLIT_VERSION([CHICHEN release],[mmux_cv_chicken_release],[$mmux_cv_chicken_release_NUMBER])
   AS_VAR_SET(CHICKEN_RELEASE_MAJOR, [$mmux_cv_chicken_release_MAJOR_VERSION])
   AS_VAR_SET(CHICKEN_RELEASE_MINOR, [$mmux_cv_chicken_release_MINOR_VERSION])
   AS_VAR_SET(CHICKEN_RELEASE_PATCH, [$mmux_cv_chicken_release_PATCH_VERSION])
   AC_SUBST([CHICKEN_RELEASE_MAJOR],[$CHICKEN_RELEASE_MAJOR])
   AC_SUBST([CHICKEN_RELEASE_MINOR],[$CHICKEN_RELEASE_MINOR])
   AC_SUBST([CHICKEN_RELEASE_PATCH],[$CHICKEN_RELEASE_PATCH])

   # Determine where shared libraries should be installed.
   #
   AS_VAR_SET(MMUX_CHICKEN_LIBDIR,[${libdir}/chicken/$mmux_cv_chicken_release_NUMBER])
   AC_MSG_NOTICE([CHICKEN libraries will be installed under: $MMUX_CHICKEN_LIBDIR])
   AC_SUBST([MMUX_CHICKEN_LIBDIR])

   # Flags variable  available on  the command  line of  "configure" and
   # "make".
   #
   AS_VAR_SET_IF(CHICKEN_FLAGS,,[AS_VAR_SET(CHICKEN_FLAGS)])
   AC_SUBST([CHICKEN_FLAGS])
   ])

dnl end of file
dnl Local Variables:
dnl mode: autoconf
dnl End:
