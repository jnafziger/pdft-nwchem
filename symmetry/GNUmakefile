#$Id: GNUmakefile,v 1.43 2008-04-02 16:55:27 d3p307 Exp $
# makefile,v 1.4 1994/11/23 18:48:11 og845 Exp

include ../config/makefile.h

LIBRARY = libnwcutil.a

USES_BLAS = sym_bs_irrep.F sym_g_sym.F    sym_geom_prj.F sym_mo_adapt.F sym_op_clsfy.F \
            sym_op_mtab.F  sym_put_geom.F dosymops.F sym_abelian.F

HEADERS = sym.fh ../NWints/auxil/spcartP.fh

OBJ =     dosymops.o \
          gensym.o \
          sym_vec_sym.o \
          ludcmp.o \
          mprint.o \
          opprint.o \
          sym_put_geom.o \
          spgen.o \
          sym_map.o \
          sym_nwc.o \
          sym_apply_op.o \
          sym_get_cart.o \
          sym_grp_name.o \
          sym_ap_cart.o \
          sym_cent_map.o \
          sym_num_ops.o \
          sym_ops_get.o \
          sym_pr_all.o \
          sym_geom_prj.o \
          cross_prod.o \
          sym_op_cname.o \
          sym_pr_ops.o \
          deter3.o \
          sym_op_clsfy.o \
          sym_tr_bs_op.o \
          sym_bs_irrep.o \
          sym_op_type.o \
          sym_char_tab.o \
          sym_pr_ctab.o \
          sym_inv_op.o \
          sym_mo_adapt.o \
          sym_g_sym.o \
          wrcell.o \
          dctr.o \
          sym_irrepname.o \
          sym_abelian.o

OBJ_OPTIMIZE = sym_sym.o \
               sym_mo_ap_op.o sym_bas_op.o

ifneq ($(TARGET),LINUX)
OBJ_OPTIMIZE += sym_sh_pair.o
else
 ifeq ($(_IFCV10),Y)
 OBJ += sym_sh_pair.o
 else
 OBJ_OPTIMIZE += sym_sh_pair.o
 endif
endif

include ../config/makelib.h
ifeq ($(_CPU),ia64)
  ifeq ($(FC),ifort)
            FOPTIONS += -save
  endif
endif

ifeq ($(TARGET),CRAY-T3D)
  FNOOPT = -g -dp -Ccray-t3d -Wf"-o noscalar,jump,noieeedivide"
$(LIBRARY_PATH)(dosymops.o):  dosymops.f
	$(FC) -c $(FNOOPT) $^
$(LIBRARY_PATH)(sym_mo_ap_op.o):  sym_mo_ap_op.F
	$(FCONVERT)
	$(FC) -c $(FNOOPT) sym_mo_ap_op.f
	@/bin/rm -f sym_mo_ap_op.f
$(LIBRARY_PATH)(sym_mo_adapt.o):  sym_mo_adapt.F
	$(FCONVERT)
	$(FC) -c $(FNOOPT) sym_mo_adapt.f
	@/bin/rm -f sym_mo_adapt.f
endif
             

