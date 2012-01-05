#
# This makefile has to be processed by GNU make
#
include ../config/makefile.h

ifdef NWCHEM_TARGET_CPU
    TARGET_CPU = $(NWCHEM_TARGET_CPU)
endif

FORCE_COMPILERS :=
ifdef CC
  FORCE_COMPILERS += CC=$(CC)
endif
ifdef FC
  FORCE_COMPILERS += FC=$(FC)
endif

  export ARMCI_DIR_NAME := armci
ifeq ($(ARMCI_NETWORK),PORTALS)
  export ARMCI_DIR_NAME := armci-portals
endif

MAKESUBDIRS = for dir in $(SUBDIRS); do $(MAKE) $(FORCE_COMPILERS)  -C $$dir $@ || exit 1 ; done
    SUBDIRS = ma global tcgmsg-mpi LinAlg/lapack+blas tcgmsg $(ARMCI_DIR_NAME)/src pario
  USE_ARMCI = yes
ifndef USE_MPI
  EXTRA_INC = "TCG_INCLUDE=../../include"
      EXTRA = "MSG_COMMS=TCGMSG"
     MP_VER = TCG
else
     MP_VER = MPI
endif

export USE_ARMCI
GA_VER = N

ifndef TARGET
info:
	@echo ''
	@echo '*** This is the Global Arrays package ****'
	@echo "*** you need to define TARGET machine, for example"
	@echo "***     setenv TARGET SUN"
	@echo "*** or "
	@echo "***     make TARGET=SUN"
	@echo ''
endif

export TARGET TARGET_CPU BINDIR

STAMP = $(TARGET)-$(MP_VER)-$(GA_VER).stamp


tools:  $(STAMP) lib/$(TARGET) include
	@echo ''
	@echo '*** Building Parallel Tools ****'
	@echo ''
	@echo '>>> making Memory Allocator (MA) library <<< '
	(cd ./ma; $(MAKE) $(FORCE_COMPILERS))
        ifdef USE_MPI
	      @echo '>>> making TCGMSG library on top of MPI <<< '
	      (cd ./tcgmsg-mpi; $(MAKE) $(FORCE_COMPILERS) MACHINE=$(TARGET) )
        else
	      @echo '>>> making TCGMSG library <<<'
	      (cd ./tcgmsg; $(MAKE) $(FORCE_COMPILERS) MACHINE=$(TARGET))
        endif
	@echo '>>> making Linear Algebra utility libraries <<< '
	(cd ./LinAlg/lapack+blas; $(MAKE) $(FORCE_COMPILERS))
ifdef   USE_ARMCI
		@echo '>>> making ARMCI remote memory copy library <<< '
		(cd ./$(ARMCI_DIR_NAME)/src; \
		$(MAKE) $(FORCE_COMPILERS) LIB_DISTRIB=../../lib $(EXTRA) $(EXTRA_INC) )
endif
	@echo '>>> making Global Arrays library <<< '
	(cd ./global; $(MAKE) $(FORCE_COMPILERS) DIAG=PAR )
	(cd ./pario; $(MAKE) $(FORCE_COMPILERS))

lib/$(TARGET):
	$(MKDIR) -p $@

include: 
	$(MKDIR) -p $@

include_stamp: tools

clean:
	$(MAKESUBDIRS) $^
	$(RM) -r include/* *.stamp
ifdef USE_ARMCI
		(cd ./$(ARMCI_DIR_NAME)/src; $(MAKE) $(FORCE_COMPILERS) LIB_DISTRIB=../../lib clean )
endif

realclean: clean


$(STAMP): 
	$(MAKE) $(FORCE_COMPILERS) clean
	echo "" > $(STAMP)

.PHONY: cleanF
cleanF:
	@echo Not done here
.PHONY: cleanDEP
cleanDEP:
	@echo Not done here
source:
	
depend:
	@echo No dependency analysis here
sngl_to_dbl dbl_to_sngl 64_to_32 32_to_64:
	@echo No blas conversion done here
#
# This is a convenience target that will make the TAGS file for current 
# checked out source tree.  This is only useful if you know something 
# about emacs.  Note: find, grep and etags must be in your path.
#
tags_file:
	find . \( -name "*.[cfFh]" -o -name "*.fh" \) -print | grep -v "\./include" | grep -v "\./tools/include" | etags -
tags_clean:
	find . -name TAGS -print -exec rm -f "{}" ";"
