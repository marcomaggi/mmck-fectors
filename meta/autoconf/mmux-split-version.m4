#
# SYNOPSIS
#
#   MMUX_SPLIT_VERSION(DESCRIPTION,STEM,VERSION_NUMBER)
#
# DESCRIPTION
#
#   Split  a version  number in  the format  MAJOR.MINOR.POINT into  its
#   separate components, cache the results in three variables.
#
#   DESCRIPTION must be a string describing the version number.
#
#   STEM must be a string variable stem used to compose the names of the
#   cache variables, which will be:
#
#      ${STEM}_MAJOR_VERSION
#      ${STEM}_MINOR_VERSION
#      ${STEM}_PATCH_VERSION
#
#   Usage example:
#
#      MMUX_SPLIT_VERSION([CHICHEN release],
#        [mmux_cv_chicken_release],5.0.0)
#
#   This macro is derived from AX_SPLIT_VERSION, which we can find at:
#
#     https://www.gnu.org/software/autoconf-archive/ax_split_version.html
#
# LICENSE
#
#   Copyright (c) 2019 Marco Maggi <marco.maggi-ipsu@poste.it>
#   Copyright (c) 2008 Tom Howard <tomhoward@users.sf.net>
#
#   Copying and distribution of this file, with or without modification,
#   are permitted in  any medium without royalty  provided the copyright
#   notice and  this notice are  preserved. This file is  offered as-is,
#   without any warranty.

AC_DEFUN([MMUX_SPLIT_VERSION],[
    AS_VAR_SET([MMUX_AX_SPLIT_VERSION_INPUT],$3)

    AC_CACHE_CHECK([$1 major version],
      [$2[]_MAJOR_VERSION],
      [AC_REQUIRE([AC_PROG_SED])
       AS_VAR_SET($2[]_MAJOR_VERSION,[`echo "$MMUX_AX_SPLIT_VERSION_INPUT" | "$SED" 's/\([[^.]][[^.]]*\).*/\1/'`])])

    AC_CACHE_CHECK([$1 major version],
      [$2[]_MINOR_VERSION],
      [AC_REQUIRE([AC_PROG_SED])
       AS_VAR_SET($2[]_MINOR_VERSION,[`echo "$MMUX_AX_SPLIT_VERSION_INPUT" | "$SED" 's/[[^.]][[^.]]*.\([[^.]][[^.]]*\).*/\1/'`])])

    AC_CACHE_CHECK([$1 major version],
      [$2[]_PATCH_VERSION],
      [AC_REQUIRE([AC_PROG_SED])
       AS_VAR_SET($2[]_PATCH_VERSION,[`echo "$MMUX_AX_SPLIT_VERSION_INPUT" | "$SED" 's/[[^.]][[^.]]*.[[^.]][[^.]]*.\(.*\)/\1/'`])])
])

### end of file
# Local Variables:
# mode: autoconf
# End:
