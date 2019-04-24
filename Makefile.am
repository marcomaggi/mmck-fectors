## Process this file with automake to produce Makefile.in

include meta/automake/mmck-rules.make


#### documentation

info_TEXINFOS		= doc/mmck-fectors.texi
doc_mmck_fectors_TEXINFOS = \
	doc/macros.texi			\
	doc/fdl-1.3.texi


#### library build targets

# All the source files of the extension library.
#
MMCK_FECTORS_MODULES		= \
	lib/mmck.fectors.core.scm		\
	lib/mmck.fectors.version.scm		\
	lib/mmck.fectors.scm

# All the object files that must be linked in the extension library.
#
MMCK_FECTORS_RUNTIME_OBJECTS	= \
	lib/mmck.fectors.core.$(OBJEXT)	\
	lib/mmck.fectors.version.$(OBJEXT)	\
	lib/mmck.fectors.$(OBJEXT)

# All the source files of all the modules' import libraries.
#
MMCK_FECTORS_IMPORT_SOURCES	= \
	lib/mmck.fectors.core.import.scm	\
	lib/mmck.fectors.version.import.scm	\
	lib/mmck.fectors.import.scm

# The module's import libraries needed to compile main module's object
# file.  It does not include the main import library:
#
#   lib/mmck.fectors.import.$(MMCK_SOEXT)
#
MMCK_FECTORS_IMPORT_DEPS	= \
	lib/mmck.fectors.core.import.$(MMCK_SOEXT)	\
	lib/mmck.fectors.version.import.$(MMCK_SOEXT)

# The import  libraries needed  to compile new  code using  the shared
# library  "(mmck fectors)".   We need  to build  and install  all of
# them.
#
MMCK_FECTORS_IMPORT_SHARED_LIBS	= \
	lib/mmck.fectors.core.import.$(MMCK_SOEXT)	\
	lib/mmck.fectors.version.import.$(MMCK_SOEXT)	\
	lib/mmck.fectors.import.$(MMCK_SOEXT)

# This is the "(mmck fectors)" shared library file pathname.
#
MMCK_FECTORS_RUNTIME_SHARED_LIBS	= lib/mmck.fectors.$(MMCK_SOEXT)

## --------------------------------------------------------------------

EXTRA_DIST	+= $(MMCK_FECTORS_MODULES)

CLEANFILES	+= \
	$(MMCK_FECTORS_RUNTIME_SHARED_LIBS)	\
	$(MMCK_FECTORS_RUNTIME_OBJECTS)	\
	$(MMCK_FECTORS_IMPORT_SHARED_LIBS)	\
	$(MMCK_FECTORS_IMPORT_SOURCES)

## --------------------------------------------------------------------

lib/mmck.fectors.version.$(OBJEXT): lib/mmck.fectors.version.scm $(MMCK_OBJECTS_DEPS)
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) $(@) $(<) -prologue lib/config.scm
	@$(MV) mmck.fectors.version.import.scm lib/mmck.fectors.version.import.scm

lib/mmck.fectors.version.import.scm: lib/mmck.fectors.version.$(OBJEXT)

lib/mmck.fectors.version.import.$(MMCK_SOEXT): lib/mmck.fectors.version.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)

## --------------------------------------------------------------------

lib/mmck.fectors.core.$(OBJEXT): lib/mmck.fectors.core.scm $(MMCK_OBJECTS_DEPS)
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) $(@) $(<)
	@$(MV) mmck.fectors.core.import.scm lib/mmck.fectors.core.import.scm

lib/mmck.fectors.core.import.scm: lib/mmck.fectors.core.$(OBJEXT)

lib/mmck.fectors.core.import.$(MMCK_SOEXT): lib/mmck.fectors.core.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)

## --------------------------------------------------------------------

# This is the main compilation unit and it defines the main module; it
# depends upon all the import libraries of the other modules.
#
lib/mmck.fectors.$(OBJEXT): lib/mmck.fectors.scm $(MMCK_FECTORS_IMPORT_DEPS) $(MMCK_OBJECTS_DEPS)
	$(MMCK_LIB_ENV) $(CSC_COMPILE_OBJECT_SHARED) $(@) $(<)
	@$(MV) mmck.fectors.import.scm lib/mmck.fectors.import.scm

lib/mmck.fectors.import.scm: lib/mmck.fectors.$(OBJEXT)

lib/mmck.fectors.import.$(MMCK_SOEXT): lib/mmck.fectors.import.scm
	$(MMCK_LIB_ENV) $(CSC_COMPILE_LIBRARY) $(@) $(<)

## --------------------------------------------------------------------

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

EXTRA_DIST		+= \
	tests/test-version.scm		\
	tests/test-fectors.scm

MMCK_CHECK_OBJECTS	= \
	tests/test-version.$(OBJEXT)	\
	tests/test-fectors.$(OBJEXT)

MMCK_CHECK_PROGS	= \
	tests/test-version.exe		\
	tests/test-fectors.exe

CLEANFILES	+= $(MMCK_CHECK_PROGS) $(MMCK_CHECK_OBJECTS)

if MMCK_TESTING_ENABLED
TESTS		= $(MMCK_CHECK_PROGS)
endif

MMCK_CHECK_DEPS	+= $(MMCK_ALL_RUNTIME_SHARED_LIBS) $(MMCK_ALL_IMPORT_LIBS)

## --------------------------------------------------------------------

tests/test-version.$(OBJEXT): tests/test-version.scm $(MMCK_CHECK_DEPS)
	$(MMCK_CHECK_ENV) $(CSC_COMPILE_OBJECT_STATIC) $(@) $(<)

tests/test-version.exe: tests/test-version.$(OBJEXT)
	$(MMCK_CHECK_ENV) $(CSC_LINK_PROGRAM) $(@) $(<)

## --------------------------------------------------------------------

tests/test-fectors.$(OBJEXT): tests/test-fectors.scm $(MMCK_CHECK_DEPS)
	$(MMCK_CHECK_ENV) $(CSC_COMPILE_OBJECT_STATIC) $(@) $(<)

tests/test-fectors.exe: tests/test-fectors.$(OBJEXT)
	$(MMCK_CHECK_ENV) $(CSC_LINK_PROGRAM) $(@) $(<)

### end of file
