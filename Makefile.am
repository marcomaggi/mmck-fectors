## Process this file with automake to produce Makefile.in

ACLOCAL_AMFLAGS		= -I autotools
AUTOMAKE_OPTIONS	= foreign
SUBDIRS			= lib doc tests
EXTRA_DIST		= INSTALL configure.sh ANNOUNCE
dist_doc_DATA		= README.org README.vicare-scheme LICENSE

vicare_test_RULES	= test tests demo demos
vicare_lib_RULES	= vfasl vfasl-installed

.PHONY: $(vicare_test_RULES) $(vicare_lib_RULES)

$(vicare_test_RULES):
	cd tests ; $(MAKE) $(@)

$(vicare_lib_RULES):
	cd lib; $(MAKE) $(@)

### end of file