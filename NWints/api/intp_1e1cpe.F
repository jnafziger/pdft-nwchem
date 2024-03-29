      subroutine intp_1e1cpe(i_basis,ish,Ri,lscr,scr,lpe,Pe)
c $Id: intp_1e1cpe.F,v 1.10 2003-10-17 22:53:42 carlfahl Exp $
      implicit none
#include "apiP.fh"
#include "errquit.fh"
#include "nwc_const.fh"
#include "basP.fh"
#include "basdeclsP.fh"
#include "geomP.fh"
#include "geobasmapP.fh"
#include "mafdecls.fh"
#include "bas_exndcf_dec.fh"
#include "bas_ibs_dec.fh"
#include "int_nbf.fh"
c::external subroutines used
c errquit
c::functions
      logical int_chk_init
      logical int_chk_sh
      logical cando_nw_1e
      logical cando_nw
      external int_chk_init
      external int_chk_sh
      external cando_nw_1e
      external cando_nw
c::passed
      integer i_basis ! basis set handle for ish functions
      integer ish     ! lexical contraction/shell index
      integer lscr    ! length of the scratch array
      integer lpe     ! length of potential energy integral array
      double precision Pe(lpe)   ! kinetic energy integral array
      double precision scr(lscr) ! scratch array
      double precision Ri(3)  ! translation vector for ish center (fractional coordinates)
c::local
      logical shells_ok
      integer i_geom, ibas, ucont
      integer Li, i_prim, i_gen, i_iexp, i_icfp, i_cent
      double precision xyz_new_i(3)  ! new coordinates for ish function center
c
#include "bas_exndcf_sfn.fh"
#include "bas_ibs_sfn.fh"
c
c check initialization and shells
c
      if (.not.int_chk_init('intp_1e1cpe'))
     &       call errquit('intp_1e1cpe: int_init was not called' ,0, 
     &                  INT_ERR)
c
      shells_ok = int_chk_sh(i_basis,ish)
      if (.not.shells_ok)
     &       call errquit('intp_1e1cpe: invalid contraction/shell',0, 
     &                 BASIS_ERR)
c
      ibas = i_basis + BASIS_HANDLE_OFFSET
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
c.. translate ish center coordinates based on Ri
      call intp_txyz(i_cent,i_geom,Ri,xyz_new_i)
c
      if (cando_nw_1e(i_basis,ish,0)) then
        call int_hf1sp(
     &         xyz_new_i,dbl_mb(mb_exndcf(i_iexp,ibas)),
     &         dbl_mb(mb_exndcf(i_icfp,ibas)),
     &         i_prim, i_gen, Li, i_cent,
     &         xyz_new_i,DCexp,DCcoeff, 1, 1, 0, i_cent,
     &         coords(1,1,i_geom),charge(1,i_geom),
     &         geom_invnucexp(1,i_geom),ncenter(i_geom),
c............................. doS     doT     doV    canonical
     &         scr,scr,Pe,lpe,.false.,.false.,.true.,.false.,
c.............. dryrun
     &         .false.,scr,lscr,'intp_1e1cpe')
        if (bas_spherical(ibas)) then
          if (Li.eq.-1) i_gen = 1
          call spcart_2ctran(Pe,scr,lscr,
     &        int_nbf_x(Li),int_nbf_s(Li),Li,i_gen,bas_spherical(ibas),
     &        int_nbf_x(0), int_nbf_s(0) ,0 ,1,.false.,
     &        .false.)
        endif
      else
        call errquit('intp_1e1cpe: could not do sp or nw integrals',0,
     &            INT_ERR)
      endif
c
      end
