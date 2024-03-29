      subroutine intp_1eke(i_basis,ish,j_basis,jsh,R,lscr,scr,lke,Ke)
c $Id: intp_1eke.F,v 1.11 2003-10-17 22:53:42 carlfahl Exp $
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
c::external subroutines used
c... errquit
c::functions
      logical cando_nw_1e
      logical cando_nw
      logical int_chk_init
      logical int_chk_sh
      external int_chk_init
      external int_chk_sh
      external cando_nw_1e
      external cando_nw
c::passed
      integer i_basis ! basis set handle for ish functions
      integer j_basis ! basis set handle for jsh functions
      integer ish     ! lexical contraction/shell index
      integer jsh     ! lexical contraction/shell index
      integer lscr    ! length of the scratch array
      integer lke     ! length of kinetic energy integral array
      double precision Ke(lke)   ! kinetic energy integral array
      double precision scr(lscr) ! scratch array
      double precision R(3)      ! translational vector in fractional coords
c::local
      logical shells_ok
      integer i_geom, j_geom, ibas, jbas, ucont
      integer Li, i_prim, i_gen, i_iexp, i_icfp, i_cent
      integer Lj, j_prim, j_gen, j_iexp, j_icfp, j_cent
      double precision xyz_new(3)  ! new coordinates for jsh function center
*rak:      integer jjj
c
      logical inline_chk_sh
      integer WarnP
      save WarnP
      data WarnP /0/
c
#include "bas_exndcf_sfn.fh"
#include "bas_ibs_sfn.fh"
c... statement function for int_chk_sh
      inline_chk_sh(ibas,ish) =
     $     ((ish.gt.0) .and. (ish.le.ncont_tot_gb(ibas)))
c
c check initialization and shells
c
      if (.not.int_chk_init('intp_1eke'))
     &       call errquit('intp_1eke: int_init was not called' ,0, 
     &          INT_ERR)
c
      ibas = i_basis + BASIS_HANDLE_OFFSET
      jbas = j_basis + BASIS_HANDLE_OFFSET
c
      shells_ok = inline_chk_sh(ibas,ish)
      shells_ok = shells_ok .and. inline_chk_sh(jbas,jsh)
      if (.not.shells_ok)
     &       call errquit('intp_1eke: invalid contraction/shell',0,
     &          INT_ERR)
c
      ucont   = (sf_ibs_cn2ucn(ish,ibas))
      Li      = infbs_cont(CONT_TYPE ,ucont,ibas)
      i_prim  = infbs_cont(CONT_NPRIM,ucont,ibas)
      i_gen   = infbs_cont(CONT_NGEN ,ucont,ibas)
      i_iexp  = infbs_cont(CONT_IEXP ,ucont,ibas)
      i_icfp  = infbs_cont(CONT_ICFP ,ucont,ibas)
      i_cent  = (sf_ibs_cn2ce(ish,ibas))
      i_geom  = ibs_geom(ibas)
c
      ucont   = (sf_ibs_cn2ucn(jsh,jbas))
      Lj      = infbs_cont(CONT_TYPE ,ucont,jbas)
      j_prim  = infbs_cont(CONT_NPRIM,ucont,jbas)
      j_gen   = infbs_cont(CONT_NGEN ,ucont,jbas)
      j_iexp  = infbs_cont(CONT_IEXP ,ucont,jbas)
      j_icfp  = infbs_cont(CONT_ICFP ,ucont,jbas)
      j_cent  = (sf_ibs_cn2ce(jsh,jbas))
      j_geom  = ibs_geom(jbas)
c
      if (i_geom.ne.j_geom.and.WarnP.eq.0) then
        write(luout,*)
     &      'intp_1eke: WARNING: possible geometry inconsistency'
        write(luout,*)'i_basis geometry handle:',i_geom
        write(luout,*)'j_basis geometry handle:',j_geom
        WarnP = 1
      endif
c
c.. translate coordinates based on R
      call intp_txyz(j_cent,j_geom,R,xyz_new)
c
      if (cando_nw_1e(i_basis,ish,0).and.cando_nw_1e(j_basis,jsh,0))
     &    then
        call int_hf1sp(
     &         coords(1,i_cent,i_geom),dbl_mb(mb_exndcf(i_iexp,ibas)),
     &         dbl_mb(mb_exndcf(i_icfp,ibas)),
     &         i_prim, i_gen, Li, i_cent,
     &         xyz_new,dbl_mb(mb_exndcf(j_iexp,jbas)),
     &         dbl_mb(mb_exndcf(j_icfp,jbas)),
     &         j_prim, j_gen, Lj, j_cent,
     &         coords(1,1,i_geom),charge(1,i_geom),
     &         geom_invnucexp(1,i_geom),ncenter(i_geom),
c............................. doS    doT     doV     canonical
     &         scr,Ke,scr,lke,.false.,.true.,.false.,.false.,
c.............. dryrun
     &         .false.,scr,lscr,'intp_1eke')
        if (bas_spherical(ibas).or.bas_spherical(jbas)) then
          if (Li.eq.-1) i_gen = 1
          if (Lj.eq.-1) j_gen = 1
          call spcart_2ctran(Ke,scr,lscr,
     &        int_nbf_x(Li),int_nbf_s(Li),Li,i_gen,bas_spherical(ibas),
     &        int_nbf_x(Lj),int_nbf_s(Lj),Lj,j_gen,bas_spherical(jbas),
     &        .false.)          
        endif
      else
        call errquit('intp_1eke: could not do sp or nw integrals',0,
     &         INT_ERR)
      endif
c
      end
