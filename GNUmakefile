
# $Id: GNUmakefile,v 1.85 2007-02-09 16:24:41 edo Exp $
TARGET = $(NWCHEM_TARGET)
include ./tools/armci/config/makecoms.h  
include ./tools/armci/config/makemp.h  
include config/makefile.h

  SUBDIRS =  $(NWSUBDIRS)

  LIB_DEFINES =  -DCOMPILATION_DATE="'`date +%a_%b_%d_%H:%M:%S_%Y`'" \
                 -DCOMPILATION_DIR="'$(TOPDIR)'" \
                 -DNWCHEM_BRANCH="'$(CODE_BRANCH)'"
ifeq ($(TARGET),FUJITSU_VPP)
  LIB_DEFINES =  -Wp,-DCOMPILATION_DATE="'`date`'" \
                 -Wp,-DCOMPILATION_DIR="'$(TOPDIR)'" \
                 -Wp,-DNWCHEM_BRANCH="'$(CODE_BRANCH)'"
endif
ifeq ($(XLFMAC),y)
  FOPTIONS +=  -WF,-DCOMPILATION_DATE="'`date`'" \
                 -WF,-DCOMPILATION_DIR="'$(TOPDIR)'" \
                 -WF,-DNWCHEM_BRANCH="'$(CODE_BRANCH)'"
  LIB_DEFINES= 
.F.o:
	$(FC) -c $(FFLAGS)     $<
endif

NWBINNAME = nwchem

#
# This should be the first target so that a simple make builds
# the entire world
#

.PHONY:	nwchem_config

.PRECIOUS:	$(BINDIR)/$(NWBINNAME) $(NWBINNAME)
all $(BINDIR)/$(NWBINNAME) $(NWBINNAME):	directories libraries
	@/bin/rm -f nwchem.o stubs.o
	$(MAKE) nwchem.o stubs.o
ifeq ($(TARGET),SOLARIS)
	/bin/rm -f $(BINDIR)/$(NWBINNAME)
endif
	$(LINK.f) -o $(BINDIR)/$(NWBINNAME) nwchem.o stubs.o -lnwctask $(LIBS)
ifdef SUMO
	$(AR) rcv $(LIBDIR)/libnwchem-sumo.a $(LIBDIR)/objs/*.o
	$(RANLIB) $(LIBDIR)/libnwchem-sumo.a
endif
	/bin/rm -f nwchem.o stubs.o
	$(INSTALL)
#
# This to link only and avoid tedious subdir makes
#

PFLAGS = -messages=first -leaks-at-exit=yes -follow-child-processes=yes \
	 -windows=no -cache-dir=/tmp/purify/cache -best-effort
#PURIFY = purify $(PFLAGS)

link nwchem_link:    
	@/bin/rm -f nwchem.o stubs.o
	$(MAKE) nwchem.o stubs.o
ifeq ($(TARGET),SOLARIS)
	/bin/rm -f $(BINDIR)/$(NWBINNAME)
endif
	$(PURIFY) $(LINK.f) -o $(BINDIR)/$(NWBINNAME) nwchem.o stubs.o -lnwctask $(LIBS)
ifdef SUMO
	$(AR) rcv $(LIBDIR)/libnwchem-sumo.a $(LIBDIR)/objs/*.o
	$(RANLIB) $(LIBDIR)/libnwchem-sumo.a
endif
#	/bin/rm -f nwchem.o stubs.o
	$(INSTALL)

ccalink:
	@echo "NWCHEM_CORE_LIBS = $(LIBS)" > ./cca/makefile.h

        
#
# This for linking version with profiling
#
prof profile:    
	@/bin/rm -f nwchem.o stubs.o
	$(MAKE) nwchem.o stubs.o
ifeq ($(TARGET),SOLARIS)
	/bin/rm -f nwchem_prof
endif
	$(LINK.f) -p -o nwchem_prof nwchem.o stubs.o -lnwctask $(LIBS)
	/bin/rm -f nwchem.o stubs.o
	$(INSTALL)
#
# This for linking test version
#
test:	nwchem.o stubs.o
ifeq ($(TARGET),SOLARIS)
	/bin/rm -f nwchem_test
endif
	$(LINK.f) -o nwchem_test nwchem.o stubs.o -lnwctask $(LIBS)
	$(INSTALL)

# This dependency so that includes which are made by libraries rule
# are updated before nwchem is compiled

libraries:
	@for dir in $(SUBDIRS); do \
		echo Making $@ in $$dir; \
		$(MAKE)	-C $$dir || exit 1 ;  \
	done
ifeq ($(TARGET),SGITFP)
	@(cd rtdb/hdbm;ls -l;touch hdbm.c;$(MAKE)) || exit 1
endif

showdir: 
	@echo "subdirectories in this build <$(SUBDIRS)>"

clean:	
	@$(MAKE) directories
	-$(RM) core *.o *.a *.trace
	@for dir in $(SUBDIRS) config ; do \
		echo Making $@ in $$dir; \
		$(MAKE)	-C $$dir clean || exit 1 ;  \
	done

realclean:	
	@$(MAKE) directories
	-$(RM) nwchem nwchem_prof nwchem_test core *.o *.a *.trace makefile.bak
	-$(RM) *~ \#*\#
	@for dir in $(SUBDIRS) config ; do \
		echo Making $@ in $$dir; \
		$(MAKE)	-C $$dir realclean || exit 1 ;  \
	done
	-$(RM) $(LIBDIR)/*.a $(BINDIR)/*
	-$(RM) *.db movecs fort.41 fort.44

.PHONY:	cleanF
cleanF:
	@for dir in $(SUBDIRS) ; do \
		echo Making $@ in $$dir; \
		$(MAKE)	-C $$dir cleanF || exit 1 ;  \
	done
	@for file in *F; do \
		body=`basename $$file .F` ; \
		if [ -f $$body.f ] ; then \
		  echo $$file and $$body.f both exist ... deleting $$body.f; \
		  /bin/rm -f $$body.f ; \
		fi ; \
        done
.PHONY:	cleanDEP
cleanDEP:
	@for dir in $(SUBDIRS) ; do \
		echo Making $@ in $$dir; \
		$(MAKE)	-C $$dir cleanDEP || exit 1 ;  \
	done
	@/bin/rm -f dependencies

sngl_to_dbl dbl_to_sngl 64_to_32 32_to_64:
	@$(MAKE) directories
	for dir in $(SUBDIRS); do \
		$(MAKE)	-C $$dir $@ || exit 1 ;  \
	done
ifeq ($(TARGET),CRAY-T3E)
	$(MAKE) cleanDEP
endif        
ifeq ($(TARGET),CRAY-T3D)
	$(MAKE) cleanDEP
endif        
#
# This rule to make necessary subdirectories in lib and bin (normally)
#

directories:
	test -d $(LIBDIR) || $(MKDIR) -p $(LIBDIR)
	test -d $(BINDIR) || $(MKDIR) -p $(BINDIR)

auxiliary:
	$(MAKE) -C nwaprep targets
	$(MAKE) -C nwajava
#
# This target will change config/nwchem_config.h include file which
# controls what we're going to build.
$(CNFDIR)/nwchem_config.h nwchem_config:
ifeq ($(NWCHEM_MODULES),)
	@echo
	@echo -----
	@echo You must set NWCHEM_MODULES to the list of modules to be \
		included in NWChem builds.
	@$(MAKE) -C config -f make_nwchem_config list-options
else
	$(MAKE) -C config -f make_nwchem_config NWCHEM_MODULES="$(NWCHEM_MODULES)"
endif

#
# This is a convenience target that will make the TAGS file for current 
# checked out source tree.  This is only useful if you know something 
# about emacs.  Note: find, grep and etags must be in your path.
#
tags_file:
	find . \( -name "*.[cfFh]" -o -name "*.fh" \) -print | grep -v "\./include" | grep -v "\./tools/include" | grep -v "NWints/seint" | etags -
tags_clean:
	find . -name TAGS -print -exec rm -f "{}" ";"

# This is a convenience target that will make sure all subdirectories
# listed in $(SUBDIRS) exist. Useful because CVS will only update
# directories that already exist in your working tree, so this is a
# way ot make sure all that are relevant to the code exist.

make_source_dirs:
ifneq ($(SUBDIRS),)
	for dir in $(SUBDIRS); do \
	   test -d $$dir  || $(MKDIR) $$dir; \
	done
endif

# This is a convenience target to remove source directories that are
# configured out of the program.  Useful to save disk space.

remove_unused_dirs:
ifneq ($(EXCLUDED_SUBDIRS),)
	for dir in $(EXCLUDED_SUBDIRS); do \
	   $(RM) -r $$dir; \
	done
endif

.PHONY:	stripdepend
stripdepend:	
	config/stripdepend

.PHONY:	source
source:	
	cat stubs.F nwchem.F > source
ifdef SUBDIRS
	for dir in $(SUBDIRS); do \
		$(MAKE)	-C $$dir $@ || exit 1 ;  \
	done
endif


