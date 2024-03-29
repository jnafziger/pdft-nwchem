c $Id: int_giaos100.F,v 1.1 2006-11-16 18:21:36 jochen Exp $
*
c:tex-% this is part of the API Standard Integral routines.
c:tex-\subsection{int\_giaos100}
c:tex-This routine computes the 1-elec GIAO integrals of type r x R(A)                      
c:tex-
c:tex-{\it Syntax:}
c:tex-\begin{verbatim}
      subroutine int_giaos100(i_basis,ish,j_basis,jsh,lscr,scr,ls10,s10)
c:tex-\end{verbatim}
      implicit none
#include "nwc_const.fh"
#include "errquit.fh"
#include "basP.fh"
#include "basdeclsP.fh"
#include "geomP.fh"
#include "geobasmapP.fh"
#include "mafdecls.fh"
#include "bas_exndcf_dec.fh"
#include "bas_ibs_dec.fh"
#include "int_nbf.fh"
#include "stdio.fh"
#include "apiP.fh"
#include "util.fh"
c::external subroutines used
c... errquit
c::functions
      logical cando_hnd_1e_prp
      logical int_chk_init
      logical int_chk_sh
      external int_chk_init
      external int_chk_sh
      external cando_hnd_1e_prp
c::passed
c:tex-\begin{verbatim}
      integer i_basis ! [input] basis set handle for ish
      integer ish     ! [input] i shell/contraction
      integer j_basis ! [input] basis set handle for jsh
      integer jsh     ! [input] j shell/contraction
      integer lscr    ! [input] length of scratch array
      double precision scr(lscr) ! [scratch] scratch array
      integer ls10               ! [input] length of s10 buffer
      double precision s10(ls10) ! [output] s10 integrals
c:tex-\end{verbatim}
c::local
      integer igeom, jgeom, ibas, jbas, ucont
      integer itype, inp, igen, iexp, icent, icf, iatom
      integer jtype, jnp, jgen, jexp, jcent, jcf, jatom
c
      logical any_spherical, trani, tranj, shells_ok
      integer i_nbf_x, j_nbf_x
      integer i_nbf_s, j_nbf_s
      integer ipts, ncartint ,i,j
c
#include "bas_exndcf_sfn.fh"
#include "bas_ibs_sfn.fh"
c
c check initialization and shells
c
      if (.not.int_chk_init('int_giaos100'))
     &       call errquit('int_giaos100: int_init was not called' ,0,
     &       INT_ERR)
c
      shells_ok = int_chk_sh(i_basis,ish)
      shells_ok = shells_ok .and. int_chk_sh(j_basis,jsh)
      if (.not.shells_ok)
     &       call errquit('int_giaos100: invalid contraction/shell',0,
     &       INT_ERR)
c
c  check if gencont
c
      call int_nogencont_check(i_basis,'int_giaos100:i_basis')
      call int_nogencont_check(j_basis,'int_giaos100:j_basis')
c
      ibas = i_basis + basis_handle_offset
      jbas = j_basis + basis_handle_offset
c
      ucont = (sf_ibs_cn2ucn(ish,ibas))
      itype = infbs_cont(CONT_TYPE ,ucont,ibas)
      inp   = infbs_cont(CONT_NPRIM,ucont,ibas)
      igen  = infbs_cont(CONT_NGEN ,ucont,ibas)
      iexp  = infbs_cont(CONT_IEXP ,ucont,ibas)
      icf   = infbs_cont(CONT_ICFP ,ucont,ibas)
      iatom = (sf_ibs_cn2ce(ish,ibas))
      igeom = ibs_geom(ibas)
c
      ucont = (sf_ibs_cn2ucn(jsh,jbas))
      jtype = infbs_cont(CONT_TYPE ,ucont,jbas)
      jnp   = infbs_cont(CONT_NPRIM,ucont,jbas)
      jgen  = infbs_cont(CONT_NGEN ,ucont,jbas)
      jexp  = infbs_cont(CONT_IEXP ,ucont,jbas)
      jcf   = infbs_cont(CONT_ICFP ,ucont,jbas)
      jatom = (sf_ibs_cn2ce(jsh,jbas))
      jgeom = ibs_geom(jbas)
c
      if (igeom.ne.jgeom) then
        write(luout,*)'int_giaos100: two different geometries for',
     &         ' properties?'
        call errquit('int_giaos100: geom error ',911, GEOM_ERR)
      endif
c
c     Determine # of cartesian integrals in block
c
      ncartint = int_nbf_x(itype)*int_nbf_x(jtype)
c
      call hnd_giaos100(
     &       coords(1,iatom,igeom),
     &       dbl_mb(mb_exndcf(iexp,ibas)),
     &       dbl_mb(mb_exndcf(icf,ibas)),
     &       inp,igen,itype,
c
     &       coords(1,jatom,jgeom),
     &       dbl_mb(mb_exndcf(jexp,jbas)),
     &       dbl_mb(mb_exndcf(jcf,jbas)),
     &       jnp,jgen,jtype,
c
     &       ncartint,s10,scr,lscr)
c
c     h01 now has three blocks, one for each component x, y, z
c      
      any_spherical = bas_spherical(ibas).or.bas_spherical(jbas)
      if (.not.any_spherical) return
c
      i_nbf_x = int_nbf_x(itype)
      j_nbf_x = int_nbf_x(jtype)
c
c... assume we need to transform both i and j integrals
c
      trani = .true.
      tranj = .true. 
*.. do not tranform i component
      if (.not.bas_spherical(ibas)) trani = .false.
*.. do not tranform j component
      if (.not.bas_spherical(jbas)) tranj = .false.
c        
c ... reset general contractions for sp shells to 1 since they are handled
c     as a block of 4.
c
      if (itype.eq.-1) igen = 1
      if (jtype.eq.-1) jgen = 1
      call spcart_2cBtran(s10,scr,lscr,
     &    j_nbf_x,int_nbf_s(jtype),jtype,jgen,tranj,
     &    i_nbf_x,int_nbf_s(itype),itype,igen,trani,
     &    3,.false.)
c
c     We now have the integrals in array (nsph_ints,3)
c
      return
      end
