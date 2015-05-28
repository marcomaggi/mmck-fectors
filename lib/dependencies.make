## dependencies.make --
#
# Automatically built.

lib/fectors.fasl: \
		lib/fectors.sls \
		$(FASL_PREREQUISITES)
	$(VICARE_COMPILE_RUN) --output $@ --compile-library $<

lib_fectors_fasldir = $(bundledlibsdir)/
lib_fectors_slsdir  = $(bundledlibsdir)/
nodist_lib_fectors_fasl_DATA = lib/fectors.fasl
if WANT_INSTALL_SOURCES
dist_lib_fectors_sls_DATA = lib/fectors.sls
endif
EXTRA_DIST += lib/fectors.sls
CLEANFILES += lib/fectors.fasl


### end of file
# Local Variables:
# mode: makefile-automake
# End:
