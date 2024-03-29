      subroutine pspw_qmmm_input(rtdb)
      implicit none
      integer rtdb

#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "geom.fh"
#include "util.fh"
#include "nwc_const.fh"
#include "errquit.fh"
c
c

      integer num_dirs          ! No. of known directives
      parameter (num_dirs = 11)
      character*30 dirs(num_dirs)
      data dirs / 'lj_ion_parameters:',
     >            'lj_ion_parameters',
     >            'lj_mm_parameters:',
     >            'polarization_mm_parameter:',
     >            'sr_basis:',
     >            'lr_cutoff:',
     >            'fragment',
     >            'nonfragment',
     >            'mm_psp',
     >            'mm_tags',
     >            'end'/

      integer num_fdirs          ! No. of known directives
      parameter (num_fdirs = 13)
      character*30 fdirs(num_fdirs)
      data fdirs / 'size',
     >             'index_start',
     >             'shake',
     >             'switching',
     >             'bond_spring',
     >             'angle_spring',
     >             'self_interaction',
     >             'incell',
     >             'cross_bond_spring',
     >             'bond_morse',
     >             'dihedral_spring',
     >             'dihedral',
     >             'end'/
c
      logical       value
      character*4   element
      character*16  tag
      character*80  rtdb_name
      integer       element_length,basis_length,tmp(2),geom
      integer       ni,nkf,nfrag,frag_size,index_start(2)
      integer       nknf,nnonfrag
      real*8        se(2),alpha,Rin,Rout,scal
      integer       nsigma
      real*8        charge,rcut
      real*8        rxyz(3),q
      character*255 test,dir_name,sdir_name
      integer ind               ! Index of matched directive

      integer h,i,j,k,ka,jstart,jlast,jstride
      character*16 psp_in,psp_out

      logical self
      integer sindx(50),na,nb,nshk
      real*8  sdist(50)
      integer nbs,nas,ncbs,nbm,nds,ndds

*     **** external functions ****
      character*7 c_index_name
      external    c_index_name

      nkf   = 0
      nfrag = 0
      nknf     = 0
      nnonfrag = 0


 10   if (.not. inp_read()) 
     >  call errquit(
     >  'pspw_qmmm_input: inp_read failed', 0, INPUT_ERR)
      if (.not. inp_a(test))
     >  call errquit(
     >  'pspw_qmmm_input: failed to read keyword', 0, INPUT_ERR)
      if (.not. inp_match(num_dirs, .false., test, dirs, ind))
     >  call errquit(
     >  'pspw_qmmm_input: unknown directive', 0, INPUT_ERR)


      goto ( 100,100, 200, 300, 400, 500, 600, 700,800,900,
     >      9999) ind
      call errquit(
     >      'pspw_qmmm_input: unimplemented directive', ind, INPUT_ERR)

c
c  LJ Ion parameters - used by model potential and model charge
c
 100  element = '    '
      value = inp_a(element)
      value = value.and.inp_f(se(1))
      value = value.and.inp_f(se(2))
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading lj_ion_parameters:',0, INPUT_ERR)

      element_length = index(element,' ') - 1
      rtdb_name = 'pspw_LJ_param_ion:'//element(1:element_length)
      value = value.and.rtdb_put(rtdb,rtdb_name,mt_dbl,2,se)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading LJ ion parameters:',0, INPUT_ERR)
      
      goto 10

c
c  LJ MM parameters - used by model potential and model charge
c
 200  element = '    '
      value = inp_a(element)
      value = value.and.inp_f(se(1))
      value = value.and.inp_f(se(2))
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading lj_mm_parameters:',0, INPUT_ERR)

      element_length = index(element,' ') - 1
      rtdb_name = 'pspw_LJ_param_mm:'//element(1:element_length)
      value = value.and.rtdb_put(rtdb,rtdb_name,mt_dbl,2,se)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading LJ MM parameters:',0, RTDB_ERR)
      
      goto 10

c
c  Polarization parameter - used by model potential and model charge
c
 300  element = '    '
      value = inp_a(element)
      value = value.and.inp_f(alpha)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading polarization_parameter:',0,
     &       INPUT_ERR)

      element_length = index(element,' ') - 1
      rtdb_name = 'pspw_polarization_mm:'//element(1:element_length)
      value = value.and.rtdb_put(rtdb,rtdb_name,mt_dbl,1,alpha)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading polarization_parameter:',0,
     &       RTDB_ERR)
      
      goto 10

c
c  SR Basis - used by model potential
c
 400  element = '    '
      value = inp_a(element)
      value = value.and.inp_f(se(1))
      value = value.and.inp_f(se(2))

      element_length = index(element,' ') - 1
      rtdb_name = 'pspw_SR_basis_length:'//element(1:element_length)
      if (.not.rtdb_get(rtdb,rtdb_name,mt_int,1,basis_length)) then
         basis_length = 0
      end if
      basis_length = basis_length+1
      value = value.and.
     >        rtdb_put(rtdb,rtdb_name,mt_int,1,basis_length)


      value = value.and.
     >         MA_push_get(mt_dbl,(2*basis_length),'tmp',tmp(2),tmp(1))

      rtdb_name = 'pspw_SR_basis:'//element(1:element_length)
      if (basis_length.gt.1) then
        value = value.and.
     >          rtdb_get(rtdb,rtdb_name,
     >                 mt_dbl,(2*basis_length-2),dbl_mb(tmp(1)))
      end if
      dbl_mb(tmp(1)+2*basis_length-2) = se(1)
      dbl_mb(tmp(1)+2*basis_length-1) = se(2)
      value = value.and.
     >        rtdb_put(rtdb,rtdb_name,
     >                 mt_dbl,(2*basis_length),dbl_mb(tmp(1)))
      value = value.and.MA_pop_stack(tmp(2))
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading SR_Basis:',0, MA_ERR)
      
      goto 10

c
c  lr_cutoff - used by model potential
c
 500  element = '    '
      value = inp_a(element)
      value = value.and.inp_f(alpha)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading lr_cutoff:',0, INPUT_ERR)

      element_length = index(element,' ') - 1
      rtdb_name = 'pspw_lr_cutoff:'//element(1:element_length)
      value = value.and.rtdb_put(rtdb,rtdb_name,mt_dbl,1,alpha)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed reading lr_cutoff:',0, RTDB_ERR)
      
      goto 10

c
c  fragment
c
 600  nkf = nkf + 1
      nshk = 0
      nas  = 0
      nbs  = 0
      ncbs  = 0
      nbm   = 0
      nds  = 0
      ndds  = 0
      rtdb_name = 'pspw_qmmm_nkfrag'
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,nkf)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing nkfrag',0, RTDB_ERR)

 601  if (.not. inp_read()) 
     >  call errquit('pspw_qmmm_input: inp_read failed',0,INPUT_ERR)
      if (.not. inp_a(test))
     >call errquit('pspw_qmmm_input:failed reading keyword',0,INPUT_ERR)
      if (.not. inp_match(num_fdirs, .false.,test,fdirs,ind))
     >  call errquit('pspw_qmmm_input: unknown directive', 0, INPUT_ERR)


      goto ( 610, 620,630,640,650,660,670,680,690,651,661,662,
     >       699) ind
      call errquit('pspw_qmmm_input:directive not found',ind,INPUT_ERR)

c
c  size
c
 610  if (.not.inp_i(frag_size)) frag_size = 1
      rtdb_name = 'pspw_qmmm_frag_size:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,frag_size)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing frag_size',0, RTDB_ERR)

      goto 601
c
c index_start
c
 620  value = MA_push_get(mt_int,nw_max_atom,'indx_start',
     >                    index_start(2),index_start(1))
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed allocating index_start',0,MA_ERR)

      ni = 0
      do while (inp_irange(jstart,jlast,jstride))
         do j=jstart,jlast,jstride
          int_mb(index_start(1)+ni) = j
          ni = ni+1
         end do
      end do
c      do while (inp_i(index_start(ni+1)))
c        ni = ni + 1
c      end do
      rtdb_name = 'pspw_qmmm_frag_index_start:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,ni,int_mb(index_start(1)))
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed writing index_start',0,RTDB_ERR)

      value = MA_pop_stack(index_start(2))
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed deallocating index_start',0,MA_ERR)

      rtdb_name = 'pspw_qmmm_frag_nindex_start:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,ni)
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed writing nindex_start',0, RTDB_ERR)

      nfrag = nfrag + ni
      rtdb_name = 'pspw_qmmm_nfrag'
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,nfrag)
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed writing nfrag',0, RTDB_ERR)

      goto 601

c
c shake
c
 630  na = 0
      if (inp_i(k)) then
         scal = 1.0d0
         sindx(na+1) = k
         na = na + 1
      else
         call get_scalefrominput(scal)
      end if
      do while (inp_i(k))
         sindx(na+1) = k
         na = na + 1
      end do
      if (inp_a(test)) then
         if (inp_contains(.false.,'c',test,k)) then
           nb = na
         else
           nb = na - 1 
         end if

         ni = 0
         do while (inp_f(alpha))
           sdist(ni+1) = (scal*alpha)**2
           ni = ni + 1
         end do
         if (ni.ge.nb) then
            nshk = nshk + 1
            rtdb_name = 'pspw_qmmm_frag_nshk:'//c_index_name(nkf)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,nshk)
            if (.not. value)
     >        call errquit(
     >       'pspw_qmmm_input:failed writing nshk',0,RTDB_ERR)

            rtdb_name = 'pspw_qmmm_frag_na:'
     >                  //c_index_name(nkf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,na)
            if (.not. value)
     >      call errquit(
     >      'pspw_qmmm_input:failed writing na',0,RTDB_ERR)

            rtdb_name = 'pspw_qmmm_frag_nb:'
     >                  //c_index_name(nkf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,nb)
            if (.not. value)
     >      call errquit(
     >      'pspw_qmmm_input:failed writing nb',0,RTDB_ERR)

            rtdb_name = 'pspw_qmmm_frag_indx_shake:'
     >                  //c_index_name(nkf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,na,sindx)
            if (.not. value)
     >      call errquit(
     >      'pspw_qmmm_input:failed writing indx_shake',0,RTDB_ERR)

            rtdb_name = 'pspw_qmmm_frag_dsq_shake:'
     >                  //c_index_name(nkf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_dbl,nb,sdist)
            if (.not. value)
     >      call errquit(
     >      'pspw_qmmm_input:failed writing dsq_shake',0,RTDB_ERR)

         end if


      end if

      goto 601
c
c switching
c
 640  if (.not.inp_f(Rin))  Rin = 0.0d0
      if (.not.inp_f(Rout)) Rout = 0.0d0

      rtdb_name = 'pspw_qmmm_frag_switch_Rin:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_dbl,1,Rin)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing switch_Rin',0, RTDB_ERR)

      rtdb_name = 'pspw_qmmm_frag_switch_Rout:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_dbl,1,Rout)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing switch_Rout',0, RTDB_ERR)

      goto 601

c
c bond spring
c
 650  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
         nbs = nbs+1
         rtdb_name = 'pspw_qmmm_frag_nbond:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nbs)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing nbs',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_bond:'
     >               //c_index_name(nkf)
     >               //c_index_name(nbs)
         value = rtdb_put(rtdb,rtdb_name,mt_int,2,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing bond spring ij',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_bond:'
     >               //c_index_name(nkf)
     >               //c_index_name(nbs)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,2,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing bond spring K,ro',0,RTDB_ERR)

      end if
      end if
      end if
      end if

      goto 601

c
c bond morse
c
 651  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
      if (inp_f(sdist(3))) then
         nbm = nbm+1
         rtdb_name = 'pspw_qmmm_frag_nmbond:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nbm)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing nbm',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_mbond:'
     >               //c_index_name(nkf)
     >               //c_index_name(nbm)
         value = rtdb_put(rtdb,rtdb_name,mt_int,2,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing bond spring ij',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_mbond:'
     >               //c_index_name(nkf)
     >               //c_index_name(nbm)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,3,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing bond spring D,rho,ro',
     >    0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if


      goto 601

c
c angle spring
c
 660  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_i(sindx(3))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
         nas = nas+1
         rtdb_name = 'pspw_qmmm_frag_nangle:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nas)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing nas',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_angle:'
     >               //c_index_name(nkf)
     >               //c_index_name(nas)
         value = rtdb_put(rtdb,rtdb_name,mt_int,3,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing bond spring ijk',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_angle:'
     >               //c_index_name(nkf)
     >               //c_index_name(nas)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,2,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing angle spring K,q0',0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if

      goto 601

c
c dihedral spring
c
 661  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_i(sindx(3))) then
      if (inp_i(sindx(4))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
         nds = nds+1
         rtdb_name='pspw_qmmm_frag_ndihedral_spring:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nds)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing nds',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_dihedral_spring:'
     >               //c_index_name(nkf)
     >               //c_index_name(nds)
         value = rtdb_put(rtdb,rtdb_name,mt_int,4,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed dihedral spring ijkl',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_dihedral_spring:'
     >               //c_index_name(nkf)
     >               //c_index_name(nds)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,2,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed dihedral spring K,q0',0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if
      end if
      goto 601

c
c dihedral
c
 662  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_i(sindx(3))) then
      if (inp_i(sindx(4))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
      if (inp_f(sdist(3))) then
         ndds = ndds+1
         rtdb_name='pspw_qmmm_frag_ndihedral:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,ndds)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing ndds',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_dihedral:'
     >               //c_index_name(nkf)
     >               //c_index_name(ndds)
         value = rtdb_put(rtdb,rtdb_name,mt_int,4,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed dihedral ijkl',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_dihedral:'
     >               //c_index_name(nkf)
     >               //c_index_name(ndds)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,3,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed dihedral K,n0,q0',0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if
      end if
      end if
      goto 601


c
c  self_interaction
c
 670  self = .true.
      if (inp_a(test)) then
        if (inp_compare(.false.,test,'on'))      self = .true.
        if (inp_compare(.false.,test,'yes'))     self = .true.
        if (inp_compare(.false.,test,'.true.'))  self = .true.
        if (inp_compare(.false.,test,'T'))       self = .true.
        if (inp_compare(.false.,test,'off'))     self = .false.
        if (inp_compare(.false.,test,'no'))      self = .false.
        if (inp_compare(.false.,test,'.false.')) self = .false.
        if (inp_compare(.false.,test,'F'))       self = .false.
      end if
      rtdb_name = 'pspw_qmmm_frag_self_interaction:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_log,1,self)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing frag_self',0, RTDB_ERR)

      goto 601


c
c  incell
c
 680  self = .true.
      if (inp_a(test)) then
        if (inp_compare(.false.,test,'on'))      self = .true.
        if (inp_compare(.false.,test,'yes'))     self = .true.
        if (inp_compare(.false.,test,'.true.'))  self = .true.
        if (inp_compare(.false.,test,'T'))       self = .true.
        if (inp_compare(.false.,test,'off'))     self = .false.
        if (inp_compare(.false.,test,'no'))      self = .false.
        if (inp_compare(.false.,test,'.false.')) self = .false.
        if (inp_compare(.false.,test,'F'))       self = .false.
      end if
      rtdb_name = 'pspw_qmmm_frag_incell:'//c_index_name(nkf)
      value = rtdb_put(rtdb,rtdb_name,mt_log,1,self)
      if (.not. value)
     >  call errquit(
     > 'pspw_qmmm_input:failed writing frag_incell',0, RTDB_ERR)

      goto 601
c
c cross bond spring i1 i2 d12  i3 i4 d34 K
c
 690  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then

      if (inp_i(sindx(3))) then
      if (inp_i(sindx(4))) then
      if (inp_f(sdist(2))) then

      if (inp_f(sdist(3))) then
         ncbs = ncbs+1
         rtdb_name = 'pspw_qmmm_frag_ncbond:'//c_index_name(nkf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,ncbs)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing ncbs',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_indx_cbond:'
     >               //c_index_name(nkf)
     >               //c_index_name(ncbs)
         value = rtdb_put(rtdb,rtdb_name,mt_int,4,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing cbond spring ijkl',0,RTDB_ERR)

         rtdb_name = 'pspw_qmmm_frag_Kr0_cbond:'
     >               //c_index_name(nkf)
     >               //c_index_name(ncbs)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,3,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_qmmm_input:failed writing cbond spring K,ro',0,RTDB_ERR)


      end if
      end if
      end if
      end if
      end if
      end if
      end if

      goto 601

 699  continue
      goto 10

c
c  nonfragment
c
 700  nknf = nknf + 1
      nshk = 0
      nas  = 0
      nbs  = 0
      ncbs  = 0
      nbm   = 0
      rtdb_name = 'pspw_2qmmm_nkfrag'
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,nknf)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing nkfrag',0, RTDB_ERR)

 701  if (.not. inp_read())
     >  call errquit('pspw_2qmmm_input: inp_read failed',0,INPUT_ERR)
      if (.not. inp_a(test)) call errquit(
     > 'pspw_2qmmm_input:failed reading keyword',0,INPUT_ERR)
      if (.not. inp_match(num_fdirs, .false.,test,fdirs,ind))
     >  call errquit('pspw_2qmmm_input: unknown directive',0,INPUT_ERR)


      goto ( 710, 720,730,740,750,760,770,780,790,751,
     >       799) ind
      call errquit('pspw_2qmmm_input:directive not found',ind,INPUT_ERR)

c
c  size
c
 710  if (.not.inp_i(frag_size)) frag_size = 1
      rtdb_name = 'pspw_2qmmm_frag_size:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,frag_size)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing frag_size',0, RTDB_ERR)

      goto 701
c
c index_start
c
 720  value = MA_push_get(mt_int,nw_max_atom,'indx_start',
     >                    index_start(2),index_start(1))
      if (.not. value) call errquit(
     > 'pspw_2qmmm_input:failed allocating index_start',0,MA_ERR)

      ni = 0
      do while (inp_irange(jstart,jlast,jstride))
         do j=jstart,jlast,jstride
          int_mb(index_start(1)+ni) = j
          ni = ni+1
         end do
      end do

      rtdb_name = 'pspw_2qmmm_frag_index_start:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,ni,int_mb(index_start(1)))
      if (.not. value) call errquit(
     > 'pspw_2qmmm_input:failed writing index_start',0,RTDB_ERR)

      value = MA_pop_stack(index_start(2))
      if (.not. value) call errquit(
     > 'pspw_2qmmm_input:failed deallocating index_start',0,MA_ERR)

      rtdb_name = 'pspw_2qmmm_frag_nindex_start:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,ni)
      if (.not. value) call errquit(
     > 'pspw_2qmmm_input:failed writing nindex_start',0, RTDB_ERR)

      nnonfrag = nnonfrag + ni
      rtdb_name = 'pspw_2qmmm_nfrag'
      value = rtdb_put(rtdb,rtdb_name,mt_int,1,nnonfrag)
      if (.not. value) call errquit(
     > 'pspw_2qmmm_input:failed writing nnonfrag',0, RTDB_ERR)

      goto 701


c
c shake
c
 730  na = 0
      if (inp_i(k)) then
         scal = 1.0d0
         sindx(na+1) = k
         na = na + 1
      else
         call get_scalefrominput(scal)
      end if
      do while (inp_i(k))
         sindx(na+1) = k
         na = na + 1
      end do
      if (inp_a(test)) then
         if (inp_contains(.false.,'c',test,k)) then
           nb = na
         else
           nb = na - 1
         end if

         ni = 0
         do while (inp_f(alpha))
           sdist(ni+1) = (scal*alpha)**2
           ni = ni + 1
         end do
         if (ni.ge.nb) then
            nshk = nshk + 1
            rtdb_name = 'pspw_2qmmm_frag_nshk:'//c_index_name(nknf)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,nshk)
            if (.not. value)
     >        call errquit(
     >       'pspw_2qmmm_input:failed writing nshk',0,RTDB_ERR)

            rtdb_name = 'pspw_2qmmm_frag_na:'
     >                  //c_index_name(nknf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,na)
            if (.not. value)
     >      call errquit(
     >      'pspw_2qmmm_input:failed writing na',0,RTDB_ERR)

            rtdb_name = 'pspw_2qmmm_frag_nb:'
     >                  //c_index_name(nknf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,1,nb)
            if (.not. value)
     >      call errquit(
     >      'pspw_2qmmm_input:failed writing nb',0,RTDB_ERR)

            rtdb_name = 'pspw_2qmmm_frag_indx_shake:'
     >                  //c_index_name(nknf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_int,na,sindx)
            if (.not. value)
     >      call errquit(
     >      'pspw_2qmmm_input:failed writing indx_shake',0,RTDB_ERR)

            rtdb_name = 'pspw_2qmmm_frag_dsq_shake:'
     >                  //c_index_name(nknf)
     >                  //c_index_name(nshk)
            value = rtdb_put(rtdb,rtdb_name,mt_dbl,nb,sdist)
            if (.not. value)
     >      call errquit(
     >      'pspw_2qmmm_input:failed writing dsq_shake',0,RTDB_ERR)

         end if

      end if

      goto 701 

c
c switching
c 
 740  if (.not.inp_f(Rin))  Rin = 0.0d0
      if (.not.inp_f(Rout)) Rout = 0.0d0

      rtdb_name = 'pspw_2qmmm_frag_switch_Rin:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_dbl,1,Rin)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing switch_Rin',0, RTDB_ERR)

      rtdb_name = 'pspw_2qmmm_frag_switch_Rout:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_dbl,1,Rout)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing switch_Rout',0, RTDB_ERR)
     
      goto 701

c
c bond spring
c
 750  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
         nbs = nbs+1
         rtdb_name = 'pspw_2qmmm_frag_nbond:'//c_index_name(nknf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nbs)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing nbs',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_indx_bond:'
     >               //c_index_name(nknf)
     >               //c_index_name(nbs)
         value = rtdb_put(rtdb,rtdb_name,mt_int,2,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing bond spring ij',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_Kr0_bond:'
     >               //c_index_name(nknf)
     >               //c_index_name(nbs)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,2,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing bond spring K,ro',0,RTDB_ERR)

      end if
      end if
      end if
      end if

      goto 701

c
c bond morse
c 
 751  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
      if (inp_f(sdist(3))) then
         nbm = nbm+1
         rtdb_name = 'pspw_2qmmm_frag_nmbond:'//c_index_name(nknf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nbm)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing nbm',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_indx_mbond:'
     >               //c_index_name(nknf)
     >               //c_index_name(nbm)
         value = rtdb_put(rtdb,rtdb_name,mt_int,2,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing bond spring ij',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_Kr0_mbond:'
     >               //c_index_name(nknf)
     >               //c_index_name(nbm)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,3,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing bond spring D,rho,ro',
     >    0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if

      goto 701

c
c angle spring
c
 760  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_i(sindx(3))) then
      if (inp_f(sdist(1))) then
      if (inp_f(sdist(2))) then
         nas = nas+1
         rtdb_name = 'pspw_2qmmm_frag_nangle:'//c_index_name(nknf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,nas)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing nas',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_indx_angle:'
     >               //c_index_name(nknf)
     >               //c_index_name(nas)
         value = rtdb_put(rtdb,rtdb_name,mt_int,3,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing bond spring ijk',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_Kr0_angle:'
     >               //c_index_name(nknf)
     >               //c_index_name(nas)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,2,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing angle spring K,q0',0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if

      goto 701
c
c  self_interaction
c
 770  self = .true.
      if (inp_a(test)) then
        if (inp_compare(.false.,test,'on'))      self = .true.
        if (inp_compare(.false.,test,'yes'))     self = .true.
        if (inp_compare(.false.,test,'.true.'))  self = .true.
        if (inp_compare(.false.,test,'T'))       self = .true.
        if (inp_compare(.false.,test,'off'))     self = .false.
        if (inp_compare(.false.,test,'no'))      self = .false.
        if (inp_compare(.false.,test,'.false.')) self = .false.
        if (inp_compare(.false.,test,'F'))       self = .false.
      end if
      rtdb_name = 
     > 'pspw_2qmmm_frag_self_interaction:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_log,1,self)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing frag_self',0, RTDB_ERR)

      goto 701
c
c  incell
c
 780  self = .true.
      if (inp_a(test)) then
        if (inp_compare(.false.,test,'on'))      self = .true.
        if (inp_compare(.false.,test,'yes'))     self = .true.
        if (inp_compare(.false.,test,'.true.'))  self = .true.
        if (inp_compare(.false.,test,'T'))       self = .true.
        if (inp_compare(.false.,test,'off'))     self = .false.
        if (inp_compare(.false.,test,'no'))      self = .false.
        if (inp_compare(.false.,test,'.false.')) self = .false.
        if (inp_compare(.false.,test,'F'))       self = .false.
      end if
      rtdb_name = 'pspw_2qmmm_frag_incell:'//c_index_name(nknf)
      value = rtdb_put(rtdb,rtdb_name,mt_log,1,self)
      if (.not. value)
     >  call errquit(
     > 'pspw_2qmmm_input:failed writing frag_incell',0, RTDB_ERR)

      goto 701

c
c cross bond spring i1 i2 d12  i3 i4 d34 K
c
 790  if (inp_i(sindx(1))) then
      if (inp_i(sindx(2))) then
      if (inp_f(sdist(1))) then
 
      if (inp_i(sindx(3))) then
      if (inp_i(sindx(4))) then
      if (inp_f(sdist(2))) then

      if (inp_f(sdist(3))) then
         ncbs = ncbs+1
         rtdb_name = 'pspw_2qmmm_frag_ncbond:'//c_index_name(nknf)
         value = rtdb_put(rtdb,rtdb_name,mt_int,1,ncbs)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing ncbs',0,RTDB_ERR)
 
         rtdb_name = 'pspw_2qmmm_frag_indx_cbond:'
     >               //c_index_name(nknf)
     >               //c_index_name(ncbs)
         value = rtdb_put(rtdb,rtdb_name,mt_int,4,sindx)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing cbond spring ijkl',0,RTDB_ERR)

         rtdb_name = 'pspw_2qmmm_frag_Kr0_cbond:'
     >               //c_index_name(nknf)
     >               //c_index_name(ncbs)
         value = rtdb_put(rtdb,rtdb_name,mt_dbl,3,sdist)
         if (.not. value)
     >   call errquit(
     >   'pspw_2qmmm_input:failed writing cbond spring K,ro',0,RTDB_ERR)

      end if
      end if
      end if
      end if
      end if
      end if
      end if

      goto 701

 799  continue
      goto 10


c
c  mm_psp
c
 800  if (inp_a(element) .and.inp_f(charge)) then
         if (.not.inp_i(nsigma)) nsigma = 4
         if (.not.inp_f(rcut))   rcut = 0.8d0

         call util_directory_name(sdir_name,.true.,0)
         call util_directory_name(dir_name,.false.,0)
         h = index(sdir_name,' ') - 1
         i = index(dir_name,' ') - 1

         open(unit=99,file=sdir_name(1:h)//'/junk.inp',status='unknown')
         close(unit=99,status='delete')

         ka = index(element,'^') - 1
         if (ka.lt.0) ka = 4
         open(unit=99,file=sdir_name(1:h)//'/junk.inp')
         write(99,*) '<QMMM>'
         write(99,'(A2,E14.6,I4,E14.6)') 
     >        element(1:ka),charge,nsigma,rcut
         write(99,*) '<end>'
         close(99)

         k = index(element,' ') - 1
         if (k.lt.0) k = 4
         psp_in  = 'junk.inp'
         psp_out = element(1:k)//".psp "
         j = index(psp_in,' ')  - 1
         k = index(psp_out,' ') - 1

         call qmmm_parse(.false.,
     >        -1,-1,1.0d0,
     >        sdir_name(1:h),h,
     >        dir_name(1:i),i,
     >        psp_in,j,
     >        psp_out(1:k),k,
     >        element(1:ka),ka)

         open(unit=99,file=sdir_name(1:h)//'/junk.inp',status='old')
         close(unit=99,status='delete')
      end if 

      goto 10
c
c  mm_tags
c
 900  value = MA_push_get(mt_int,nw_max_atom,'indx_start',
     >                    index_start(2),index_start(1))
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed allocating mm_tags',0,MA_ERR)

      ni = 0
      do while (inp_irange(jstart,jlast,jstride))
         do j=jstart,jlast,jstride
          int_mb(index_start(1)+ni) = j
          ni = ni+1
         end do
      end do
      element = '    '
      if (.not.inp_a(element)) element = '    '

      if (geom_create(geom,'geometry')) then
      if (geom_rtdb_load(rtdb,geom,'geometry')) then

c     *** remove ^ from tags ****
      if (inp_compare(.false.,element,'off')) then
         do j=1,ni
            i = int_mb(index_start(1)+j-1)
            value = geom_cent_get(geom,i,tag,rxyz,q)
            k = index(tag,'^') 
            if (k.gt.0) then
               do ka=k,16
                  tag(ka:ka) = ' '
               end do
               value = geom_cent_set(geom,i,tag,rxyz,q)
            end if
         end do

c     *** add ^ to tags ****
      else
         element = '^'//element(1:1)
         do j=1,ni
            i = int_mb(index_start(1)+j-1)
            value = geom_cent_get(geom,i,tag,rxyz,q)
            k = index(tag,' ') - 1
            if (k.gt.0) then
               tag = tag(1:k)//element
               value = geom_cent_set(geom,i,tag,rxyz,q)
            end if
         end do
      end if

      value = geom_rtdb_delete(rtdb,'geometry')
      value = geom_rtdb_store(rtdb,geom,'geometry')
      value = geom_destroy(geom)

      end if
      end if



      value = MA_pop_stack(index_start(2))
      if (.not. value) call errquit(
     > 'pspw_qmmm_input:failed deallocating mm_tags',0,MA_ERR)

      goto 10

 9999 continue

      return
      end
