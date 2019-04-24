# mmck-chicken-rules.make --
#
# This file is meant to be included by "Makefile.am".

ACLOCAL_AMFLAGS		= -I meta/autotools
AUTOMAKE_OPTIONS	= foreign
EXTRA_DIST		= INSTALL
CLEANFILES		=
MAINTAINERCLEANFILES	= lib/config.scm
dist_doc_DATA		= README COPYING

# File  name  extensions  for  shared objects  and  shared  libraries.
# Notice that, on every platform,  CHICKEN uses ".so" as extension for
# shared  libraries;  it  does  not  care  about  ".dll"  or  ".dyld".
# Because.
#
OBJEXT			= o
MMCK_SOEXT		= so

MV			= mv


#### documentation

AM_MAKEINFOFLAGS	= --no-split
AM_MAKEINFOHTMLFLAGS	= --split=node -c WORDS_IN_PAGE=0 \
	-c PRE_BODY_CLOSE="<p>This document describes version <tt>$(PACKAGE_VERSION)</tt> of <em>$(PACKAGE_NAME)</em>.</p>"


#### CHICKEN compiler command lines and flags

# Included   in   every   compiler   command   line.    The   variable
# "CHICKEN_FLAGS" is available  for the user to be set  on the command
# line of "make":
#
#   $ make CHICKEN_FLAGS=...
#
AM_CHICKEN_FLAGS		= $(CHICKEN_FLAGS)

# Included in every compiler command line used to compile object files
# for a shared library.
#
AM_CHICKEN_FLAGS_OBJECT_SHARED	= -dynamic $(AM_CHICKEN_FLAGS)

# Included in every compiler command line used to compile object files
# for a program.
#
AM_CHICKEN_FLAGS_OBJECT_STATIC	= $(AM_CHICKEN_FLAGS)

## --------------------------------------------------------------------

# Included in every compiler command line used to link object files in
# a shared library.  The  variable "CHICKEN_LIBFLAGS" is available for
# the user to be set on the command line of "make":
#
#   $ make CHICKEN_LIBFLAGS=...
#
AM_CHICKEN_LIBFLAGS	= -library $(AM_CHICKEN_FLAGS) $(CHICKEN_LIBFLAGS)

# Included in every compiler command line used to link object files in
# a program.   The variable  "CHICKEN_PROGFLAGS" is available  for the
# user to be set on the command line of "make":
#
#   $ make CHICKEN_PROGFLAGS=...
#
AM_CHICKEN_PROGFLAGS	= $(AM_CHICKEN_FLAGS) $(CHICKEN_PROGFLAGS)

## --------------------------------------------------------------------

# Compile an object file to be used in a shared library.
#
CSC_COMPILE_OBJECT_SHARED	= $(CHICKEN_COMPILER) $(AM_CHICKEN_FLAGS_OBJECT_SHARED) -c -o

# Compile an object file to be used in a program.
#
CSC_COMPILE_OBJECT_STATIC	= $(CHICKEN_COMPILER) $(AM_CHICKEN_FLAGS_OBJECT_STATIC) -c -o

# Compile object files into a shared  library.  We use this for import
# libraries.
#
CSC_COMPILE_LIBRARY		= $(CHICKEN_COMPILER) $(AM_CHICKEN_LIBFLAGS) -o

# Link object files into a shared library.
#
CSC_LINK_LIBRARY		= $(CHICKEN_COMPILER) $(AM_CHICKEN_LIBFLAGS) -o

# Link object files into a program.
#
CSC_LINK_PROGRAM		= $(CHICKEN_COMPILER) $(AM_CHICKEN_PROGFLAGS) -o


#### rules and variable definitions for all build targets
#
# We  expect the  library's source  files  to be  under the  directory
# "$(top_srcdir)/lib".
#

# We need  to define a  repository path to  let the compiler  find the
# modules' import  libraries while  compiling modules  importing other
# modules.
#
MMCK_LIB_REPOSITORY_PATH	= $(abs_builddir)/lib:$(CHICKEN_REPOSITORY_PATH)

# This is  the shell environment  in which  we invoke the  compiler to
# compile object files and link the extension library.
#
MMCK_LIB_ENV			= CHICKEN_REPOSITORY_PATH=$(MMCK_LIB_REPOSITORY_PATH); export CHICKEN_REPOSITORY_PATH;

## --------------------------------------------------------------------

# Common dependencies to build every object file.
#
# Before attempting to compile the libraries: let's make sure that the
# directory "$(builddir)/lib" exists,  even when we perform  an out of
# tree build.
#
MMCK_OBJECTS_DEPS		= lib/$(am__dirstamp)

CLEANFILES			+= lib/$(am__dirstamp)

lib/$(am__dirstamp):
	@$(MKDIR_P) lib
	@: > lib/$(am__dirstamp)


#### interface to "make check"
#
# Read "Parallel Test Harness" in the documentation of GNU Automake to
# understand how to use this interface for "make check".
#

# This  variable collects  the  shell environment  that  is set  while
# running the test programs with "make check".
#
MMCK_CHECK_ENV =

# Let's make  sure the  compiler and  the test  programs can  find the
# libraries built by this package; for this purpose we prepend a local
# directory to CHICKEN_REPOSITORY_PATH.
#
MMCK_CHECK_ENV += CHICKEN_REPOSITORY_PATH=$(abs_builddir)/lib:$(CHICKEN_REPOSITORY_PATH); export CHICKEN_REPOSITORY_PATH;

# In this shell environment we also set LD_LIBRARY_PATH (for Unix) and
# DYLD_LIBRARY_PATH (for Darwin) to allow  the programs to find shared
# libraries  that are  built using  GNU Libtool.   These settings  are
# there even if this package does not build such libraries.  Sue me...
#
MMCK_CHECK_ENV += LD_LIBRARY_PATH=$(builddir)/.libs:$(LD_LIBRARY_PATH); export LD_LIBRARY_PATH;
MMCK_CHECK_ENV += DYLD_LIBRARY_PATH=$(builddir)/.libs:$(DYLD_LIBRARY_PATH); export DYLD_LIBRARY_PATH;

# While  running "make  check" with  a  test suite  using the  library
# "(mmck checks)":  we do not want  a quiet execution, rather  we want
# the output to go to the log files.
#
MMCK_CHECK_ENV += CHECKS_QUIET=no; export CHECKS_QUIET;

# While  running "make  check" with  a  test suite  using the  library
# "(mmck checks)": we might want to  select a set of tests to execute.
# For this we could run:
#
#   make check CHECKS_NAME=<test-name>
#
# but the following environment setup will allow us to do:
#
#   make check name=<test-name>
#
# which is shorter.
#
MMCK_CHECK_ENV += CHECKS_NAME=$(name); export CHECKS_NAME;

# Occasionally we might want to hand  some pathname to the code of the
# test programs, to read some sort of data files.
#
MMCK_CHECK_ENV += MMCK_SOURCE_PATH=$(srcdir)/tests:$(srcdir)/lib; export MMCK_SOURCE_PATH;
MMCK_CHECK_ENV += MMCK_SRCDIR=$(srcdir)/tests; export MMCK_SRCDIR;
MMCK_CHECK_ENV += MMCK_BUILDDIR=$(builddir); export MMCK_BUILDDIR;

# This interfaces with GNU Automake's parallel test harness.
#
AM_TESTS_ENVIRONMENT	= $(MMCK_CHECK_ENV)

## --------------------------------------------------------------------

# Before attempting  to compile  the tests: let's  make sure  that the
# directory "$(builddir)/tests" exists, even when we perform an out of
# tree build.
#
MMCK_CHECK_DEPS	= tests/$(am__dirstamp)

CLEANFILES	+= tests/$(am__dirstamp)

tests/$(am__dirstamp):
	@$(MKDIR_P) tests
	@: > tests/$(am__dirstamp)


#### interface to "make instcheck"

# This  variable collects  the  shell environment  that  is set  while
# running the test programs with "make installcheck".
#
MMCK_INSTALLCHECK_ENV =

# Let's make  sure the  compiler and  the test  programs can  find the
# libraries  built and  installed by  this package,  even when  we run
# "make  distcheck";  for  this  purpose we  prepend  the  appropriate
# directory to CHICKEN_REPOSITORY_PATH.
#
MMCK_INSTALLCHECK_ENV += CHICKEN_REPOSITORY_PATH=$(DESTDIR)$(MMUX_CHICKEN_LIBDIR):$(CHICKEN_REPOSITORY_PATH); export CHICKEN_REPOSITORY_PATH;

# In this shell environment we also set LD_LIBRARY_PATH (for Unix) and
# DYLD_LIBRARY_PATH (for Darwin) to allow  the programs to find shared
# libraries  that are  built using  GNU Libtool.   These settings  are
# there even if this package does not build such libraries.  Sue me...
#
MMCK_INSTALLCHECK_ENV += LD_LIBRARY_PATH=$(DESTDIR)$(libdir):$(LD_LIBRARY_PATH); export LD_LIBRARY_PATH;
MMCK_INSTALLCHECK_ENV += DYLD_LIBRARY_PATH=$(DESTDIR)$(libdir):$(DYLD_LIBRARY_PATH); export DYLD_LIBRARY_PATH;

# While  running  "make installcheck"  with  a  test suite  using  the
# library "(mmck checks)": we do not want a quiet execution, rather we
# want the output to go to the standard output.
#
MMCK_INSTALLCHECK_ENV += CHECKS_QUIET=no; export CHECKS_QUIET;

# While  running "make  check" with  a  test suite  using the  library
# "(mmck checks)": we might want to  select a set of tests to execute.
# For this we could run:
#
#   make installcheck CHECKS_NAME=<test-name>
#
# but the following environment setup will allow us to do:
#
#   make instalcheck name=<test-name>
#
# which is shorter.
#
MMCK_INSTALLCHECK_ENV += CHECKS_NAME=$(name); export CHECKS_NAME;

# Occasionally we might want to hand  some pathname to the code of the
# test programs, to read some sort of data files.
#
MMCK_INSTALLCHECK_ENV += MMCK_SOURCE_PATH=$(srcdir)/tests:$(srcdir)/lib; export MMCK_SOURCE_PATH;
MMCK_INSTALLCHECK_ENV += MMCK_SRCDIR=$(srcdir)/tests; export MMCK_SRCDIR;
MMCK_INSTALLCHECK_ENV += MMCK_BUILDDIR=$(builddir); export MMCK_BUILDDIR;

installcheck-local: $(TESTS)
	@for f in $(TESTS); do $(MMCK_INSTALLCHECK_ENV) $(builddir)/$$f; done
	@for f in $(srcdir)/tests/test-*.scm; do $(MMCK_INSTALLCHECK_ENV) $(CHICKEN_INTERPRETER) -no-init -script $$f; done


#### running the interpreter and the tests

.PHONY: repl test tests

repl:
	$(MMCK_CHECK_ENV) $(CHICKEN_INTERPRETER)

test tests: $(TESTS)
	for f in $(builddir)/tests/test-*$(file)*.exe; do $(MMCK_CHECK_ENV) $$f; done

### end of file
