## Process this file with automake to produce Makefile.in

include meta/automake/mmck-rules.make


#### documentation

info_TEXINFOS		= doc/mmck-fectors.texi
doc_mmck_fectors_TEXINFOS = \
	doc/macros.texi			\
	doc/fdl-1.3.texi


#### library build targets

# All the source files ".scm" of the extension library.
#
MMCK_FECTORS_MODULES		=

# All  the object  files ".o"  that must  be linked  in the  extension
# library.
#
MMCK_FECTORS_RUNTIME_OBJECTS	=

# All  the  source files  ".import.scm"  of  all the  modules'  import
# libraries.
#
MMCK_FECTORS_IMPORT_SOURCES	=

# The  module's  import  libraries ".import.$(MMCK_SOEXT)"  needed  to
# compile main  module's object  file.  It does  not include  the main
# import library:
#
#   lib/mmck.fectors.import.$(MMCK_SOEXT)
#
MMCK_FECTORS_IMPORT_DEPS		=

# The import  libraries ".import.$(MMCK_SOEXT)" needed to  compile new
# code using the  shared library "(mmck fectors)".  We  need to build
# and install all of them.
#
MMCK_FECTORS_IMPORT_SHARED_LIBS	=

# This is the "(mmck fectors)" shared library file pathname.
#
MMCK_FECTORS_RUNTIME_SHARED_LIBS	= \
	lib/mmck.fectors.$(MMCK_SOEXT)

# Temporary  files  we need  for  parallel  builds, ".temp",  ".lock",
# ".stamp".
#
MMCK_FECTORS_TEMP_FILES		=


#### library (mmck fectors): module version

MMCK_FECTORS_MODULES			+= lib/mmck.fectors.version.scm
MMCK_FECTORS_RUNTIME_OBJECTS		+= lib/mmck.fectors.version.$(OBJEXT)
MMCK_FECTORS_IMPORT_SOURCES		+= lib/mmck.fectors.version.import.scm
MMCK_FECTORS_IMPORT_DEPS		+= lib/mmck.fectors.version.import.$(MMCK_SOEXT)
MMCK_FECTORS_IMPORT_SHARED_LIBS	+= lib/mmck.fectors.version.import.$(MMCK_SOEXT)
MMCK_FECTORS_TEMP_FILES		+= \
	lib/mmck.fectors.version.temp				\
	lib/mmck.fectors.version.lock				\
	lib/mmck.fectors.version.stamp

# A compiler  invokation to build  an object file, also  generates the
# source  file for  the import  library; a  single rule  generates two
# targets.  We implement  the rules as suggested  in the documentation
# of GNU Automake, node "Multiple Outputs".
#
# It is ugly, I know.  But it  is supposed to support all the cases of
# parallel build and dry runs.  (Marco Maggi; May  4, 2019)
#
lib/mmck.fectors.version.stamp: lib/mmck.fectors.version.scm $(MMCK_OBJECTS_DEPS)
	@rm -f lib/mmck.fectors.version.temp
	@touch lib/mmck.fectors.version.temp
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) lib/mmck.fectors.version.$(OBJEXT) $(<) -prologue lib/config.scm
	@$(MV) mmck.fectors.version.import.scm lib/mmck.fectors.version.import.scm
	@mv -f lib/mmck.fectors.version.temp $@

lib/mmck.fectors.version.import.scm lib/mmck.fectors.version.$(OBJEXT): lib/mmck.fectors.version.stamp
	@dry=; for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=*|--*);; \
	    *n*) dry=:;; \
	  esac; \
	done; \
	if test -f $@; then :; else \
	  $$dry trap 'rm -rf lib/mmck.fectors.version.lock lib/mmck.fectors.version.stamp' 1 2 13 15; \
	  if $$dry mkdir lib/mmck.fectors.version.lock 2>/dev/null; then \
	    $$dry rm -f lib/mmck.fectors.version.stamp; \
	    $(MAKE) $(AM_MAKEFLAGS) lib/mmck.fectors.version.stamp; \
	    $$dry rmdir lib/mmck.fectors.version.lock; \
	  else \
	    while test -d lib/mmck.fectors.version.lock && test -z "$$dry"; do \
	      sleep 1; \
	    done; \
	    $$dry test -f lib/mmck.fectors.version.stamp; exit $$?; \
	  fi; \
	fi

lib/mmck.fectors.version.import.$(MMCK_SOEXT): lib/mmck.fectors.version.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)


#### library (mmck fectors): module core

MMCK_FECTORS_MODULES			+= lib/mmck.fectors.core.scm
MMCK_FECTORS_RUNTIME_OBJECTS		+= lib/mmck.fectors.core.$(OBJEXT)
MMCK_FECTORS_IMPORT_SOURCES		+= lib/mmck.fectors.core.import.scm
MMCK_FECTORS_IMPORT_DEPS		+= lib/mmck.fectors.core.import.$(MMCK_SOEXT)
MMCK_FECTORS_IMPORT_SHARED_LIBS	+= lib/mmck.fectors.core.import.$(MMCK_SOEXT)
MMCK_FECTORS_TEMP_FILES		+= \
	lib/mmck.fectors.core.temp	\
	lib/mmck.fectors.core.lock	\
	lib/mmck.fectors.core.stamp

MMCK_FECTORS_CORE_DEPS = \
	$(MMCK_OBJECTS_DEPS)

lib/mmck.fectors.core.stamp: lib/mmck.fectors.core.scm $(MMCK_FECTORS_CORE_DEPS)
	@rm -f lib/mmck.fectors.core.temp
	@touch lib/mmck.fectors.core.temp
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) lib/mmck.fectors.core.$(OBJEXT) $(<)
	@$(MV) mmck.fectors.core.import.scm lib/mmck.fectors.core.import.scm
	@mv -f lib/mmck.fectors.core.temp $@

lib/mmck.fectors.core.import.scm lib/mmck.fectors.core.$(OBJEXT): lib/mmck.fectors.core.stamp
	@dry=; for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=*|--*);; \
	    *n*) dry=:;; \
	  esac; \
	done; \
	if test -f $@; then :; else \
	  $$dry trap 'rm -rf lib/mmck.fectors.core.lock lib/mmck.fectors.core.stamp' 1 2 13 15; \
	  if $$dry mkdir lib/mmck.fectors.core.lock 2>/dev/null; then \
	    $$dry rm -f lib/mmck.fectors.core.stamp; \
	    $(MAKE) $(AM_MAKEFLAGS) lib/mmck.fectors.core.stamp; \
	    $$dry rmdir lib/mmck.fectors.core.lock; \
	  else \
	    while test -d lib/mmck.fectors.core.lock && test -z "$$dry"; do \
	      sleep 1; \
	    done; \
	    $$dry test -f lib/mmck.fectors.core.stamp; exit $$?; \
	  fi; \
	fi

lib/mmck.fectors.core.import.$(MMCK_SOEXT): lib/mmck.fectors.core.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)


#### library (mmck fectors): main module

MMCK_FECTORS_MODULES		+= lib/mmck.fectors.scm
MMCK_FECTORS_RUNTIME_OBJECTS	+= lib/mmck.fectors.$(OBJEXT)
MMCK_FECTORS_IMPORT_SOURCES	+= lib/mmck.fectors.import.scm
MMCK_FECTORS_IMPORT_SHARED_LIBS	+= lib/mmck.fectors.import.$(MMCK_SOEXT)
MMCK_FECTORS_TEMP_FILES		+= \
	lib/mmck.fectors.temp				\
	lib/mmck.fectors.lock				\
	lib/mmck.fectors.stamp

# This is the main compilation unit and it defines the main module; it
# depends upon all the import libraries of the other modules.
#
lib/mmck.fectors.stamp: lib/mmck.fectors.scm $(MMCK_FECTORS_IMPORT_DEPS) $(MMCK_OBJECTS_DEPS)
	@rm -f lib/mmck.fectors.temp
	@touch lib/mmck.fectors.temp
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) lib/mmck.fectors.$(OBJEXT) $(<)
	@$(MV) mmck.fectors.import.scm lib/mmck.fectors.import.scm
	@mv -f lib/mmck.fectors.temp $@

lib/mmck.fectors.import.scm lib/mmck.fectors.$(OBJEXT): lib/mmck.fectors.stamp
	@dry=; for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=*|--*);; \
	    *n*) dry=:;; \
	  esac; \
	done; \
	if test -f $@; then :; else \
	  $$dry trap 'rm -rf lib/mmck.fectors.lock lib/mmck.fectors.stamp' 1 2 13 15; \
	  if $$dry mkdir lib/mmck.fectors.lock 2>/dev/null; then \
	    $$dry rm -f lib/mmck.fectors.stamp; \
	    $(MAKE) $(AM_MAKEFLAGS) lib/mmck.fectors.stamp; \
	    $$dry rmdir lib/mmck.fectors.lock; \
	  else \
	    while test -d lib/mmck.fectors.lock && test -z "$$dry"; do \
	      sleep 1; \
	    done; \
	    $$dry test -f lib/mmck.fectors.stamp; exit $$?; \
	  fi; \
	fi

lib/mmck.fectors.import.$(MMCK_SOEXT): lib/mmck.fectors.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)


#### library (mmck fectors): wrapping up

EXTRA_DIST	+= $(MMCK_FECTORS_MODULES)

CLEANFILES	+= \
	$(MMCK_FECTORS_RUNTIME_SHARED_LIBS)	\
	$(MMCK_FECTORS_RUNTIME_OBJECTS)		\
	$(MMCK_FECTORS_IMPORT_SHARED_LIBS)	\
	$(MMCK_FECTORS_IMPORT_SOURCES)		\
	$(MMCK_FECTORS_TEMP_FILES)

lib/mmck.fectors.$(MMCK_SOEXT): $(MMCK_FECTORS_RUNTIME_OBJECTS)
	$(MMCK_LIB_ENV) $(CSC_LINK_LIBRARY) $(@) $(^)


#### shared libraries installation

# All the import shared libraries that we want to installe.
#
MMCK_ALL_IMPORT_SHARED_LIBS	= \
	$(MMCK_FECTORS_IMPORT_SHARED_LIBS)

# All the runtime shared libraries that we want to install.
#
MMCK_ALL_RUNTIME_SHARED_LIBS	= \
	$(MMCK_FECTORS_RUNTIME_SHARED_LIBS)

# These variables are parsed by GNU Automake to build the main library
# targets and install them under the directory $(MMUX_CHICKEN_LIBDIR).
#
# We are shamelessly cheating by  installing them using GNU Automake's
# primary  suffix  "_SCRIPTS"; these  are  not  scripts!  Scripts  are
# installed with the permissions 0755, which, for some reason, is what
# we want  for shared libraries.
#
# We  could use  the  primary suffix  "_DATA", but  we  would get  the
# permissions 0644.
#
sharedlibdir		= $(MMUX_CHICKEN_LIBDIR)
sharedlib_SCRIPTS	= $(MMCK_ALL_RUNTIME_SHARED_LIBS) $(MMCK_ALL_IMPORT_SHARED_LIBS)


#### interface to "make check"
#
# Read "Parallel Test Harness" in the documentation of GNU Automake to
# understand how to use this interface for "make check".
#

# The list of object files.  We will store it in CLEANFILES.
#
MMCK_CHECK_OBJECTS	=

# The list of test programs.  We will set TESTS to it.
#
MMCK_CHECK_PROGS	=

# Dependencies common to all the test programs.
#
MMCK_CHECK_DEPS		+= $(MMCK_ALL_RUNTIME_SHARED_LIBS) $(MMCK_ALL_IMPORT_LIBS)

## --------------------------------------------------------------------

EXTRA_DIST		+= tests/test-version.scm
MMCK_CHECK_OBJECTS	+= tests/test-version.$(OBJEXT)
MMCK_CHECK_PROGS	+= tests/test-version.exe

tests/test-version.$(OBJEXT): tests/test-version.scm $(MMCK_CHECK_DEPS)
	$(MMCK_CHECK_ENV) $(CSC_COMPILE_OBJECT_STATIC) $(@) $(<)

tests/test-version.exe: tests/test-version.$(OBJEXT)
	$(MMCK_CHECK_ENV) $(CSC_LINK_PROGRAM) $(@) $(<)

## --------------------------------------------------------------------

EXTRA_DIST		+= tests/test-fectors.scm
MMCK_CHECK_OBJECTS	+= tests/test-fectors.$(OBJEXT)
MMCK_CHECK_PROGS	+= tests/test-fectors.exe

tests/test-fectors.$(OBJEXT): tests/test-fectors.scm $(MMCK_CHECK_DEPS)
	$(MMCK_CHECK_ENV) $(CSC_COMPILE_OBJECT_STATIC) $(@) $(<)

tests/test-fectors.exe: tests/test-fectors.$(OBJEXT)
	$(MMCK_CHECK_ENV) $(CSC_LINK_PROGRAM) $(@) $(<)


#### wrapping up tests

CLEANFILES	+= $(MMCK_CHECK_PROGS) $(MMCK_CHECK_OBJECTS)

TESTS		= $(MMCK_CHECK_PROGS)

### end of file
