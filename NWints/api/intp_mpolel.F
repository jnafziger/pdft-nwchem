      subroutine intp_mpolel(i_basis, ish, j_basis, jsh, R,
     &    lval, centerl,
     &    lscr, scr, lmpint, MP, num_mpint)
*
* $Id: intp_mpolel.F,v 1.5 2003-10-17 22:53:42 carlfahl Exp $
*
c
c routine to compute multipole integrals at a given lvalue with the
c jsh translated by the fractional coordinate vector R.
c The general form is <shell|pole|shell>
c
c the returned buffer is logically (mpole range, jlo:jhi, ilo:ihi)
c where mpole range is 1:((lval+1)*(lval+2)/2)
c
c  Integrals are returned in shell blocks of <L|ish|jsh> L=lval
c  one block for the given L value.  
c  for ish = d and Lval = 1 and jsh = p you would get:
c      (6*3*3)=54 integrals
c  order would be 
c   <xx|x|x> <xx|y|x> <xx|z|x> ( 1- 3)
c   <xx|x|y> <xx|y|y> <xx|z|y> ( 4- 6) 
c   <xx|x|z> <xx|y|z> <xx|z|z> ( 7- 9)
c   <xy|x|x> <xy|y|x> <xy|z|x> (10-12)
c   <xy|x|y> <xy|y|y> <xy|z|y> (13-15)
c   <xy|x|z> <xy|y|z> <xy|z|z> (16-18)
c   <xz|x|x> <xz|y|x> <xz|z|x> (19-21)
c   <xz|x|y> <xz|y|y> <xz|z|y> (22-24)
c   <xz|x|z> <xz|y|z> <xz|z|z> (25-27)
c   <yy|x|x> <yy|y|x> <yy|z|x> (28-30)
c   <yy|x|y> <yy|y|y> <yy|z|y> (31-33)
c   <yy|x|z> <yy|y|z> <yy|z|z> (34-36)
c   <yz|x|x> <yz|y|x> <yz|z|x> (37-39)
c   <yz|x|y> <yz|y|y> <yz|z|y> (40-42)
c   <yz|x|z> <yz|y|z> <yz|z|z> (43-45)
c   <zz|x|x> <zz|y|x> <zz|z|x> (46-48)
c   <zz|x|y> <zz|y|y> <zz|z|y> (49-51)
c   <zz|x|z> <zz|y|z> <zz|z|z> (52-54)
c
c
c  for ish = p and Lval = 2 and jsh = p you would get:
c      (3*6*3) = 54 integrals
c  order would be 
c   <x|xx|x> <x|xy|x> <x|xz|x> <x|yy|x> <x|yz|x> <x|zz|x>  ( 1- 6)
c   <x|xx|y> <x|xy|y> <x|xz|y> <x|yy|y> <x|yz|y> <x|zz|y>  ( 7-12)
c   <x|xx|z> <x|xy|z> <x|xz|z> <x|yy|z> <x|yz|z> <x|zz|z>  (13-18)
c   <y|xx|x> <y|xy|x> <y|xz|x> <y|yy|x> <y|yz|x> <y|zz|x>  (19-24)
c   <y|xx|y> <y|xy|y> <y|xz|y> <y|yy|y> <y|yz|y> <y|zz|y>  (25-30)
c   <y|xx|z> <y|xy|z> <y|xz|z> <y|yy|z> <y|yz|z> <y|zz|z>  (31-36)
c   <z|xx|x> <z|xy|x> <z|xz|x> <z|yy|x> <z|yz|x> <z|zz|x>  (37-42)
c   <z|xx|y> <z|xy|y> <z|xz|y> <z|yy|y> <z|yz|y> <z|zz|y>  (43-48)
c   <z|xx|z> <z|xy|z> <z|xz|z> <z|yy|z> <z|yz|z> <z|zz|z>  (49-54)
c
c  for ish = s and lval = 4 and jsh = p you would get:
c     (1*15*3) = 45 integrals
c   <s|xxxx|x> <s|xxxy|x> <s|xxxz|x> <s|xxyy|x> <s|xxyz|x> <s|xxzz|x> ( 1- 6)
c   <s|xyyy|x> <s|xyyz|x> <s|xyzz|x> <s|xzzz|x> <s|yyyy|x> <s|yyyz|x> ( 7-12)
c   <s|yyzz|x> <s|yzzz|x> <s|zzzz|x>                                  (13-15)
c   <s|xxxx|y> <s|xxxy|y> <s|xxxz|y> <s|xxyy|y> <s|xxyz|y> <s|xxzz|y> (16-21)
c   <s|xyyy|y> <s|xyyz|y> <s|xyzz|y> <s|xzzz|y> <s|yyyy|y> <s|yyyz|y> (22-27)
c   <s|yyzz|y> <s|yzzz|y> <s|zzzz|y>                                  (28-30)
c   <s|xxxx|z> <s|xxxy|z> <s|xxxz|z> <s|xxyy|z> <s|xxyz|z> <s|xxzz|z> (31-36)
c   <s|xyyy|z> <s|xyyz|z> <s|xyzz|z> <s|xzzz|z> <s|yyyy|z> <s|yyyz|z> (37-42)
c   <s|yyzz|z> <s|yzzz|z> <s|zzzz|z>                                  (43-45)
c
c
      implicit none
#include "apiP.fh"
#include "errquit.fh"
#include "nwc_const.fh"
#include "basP.fh"
#include "basdeclsP.fh"
#include "geobasmapP.fh"
#include "geomP.fh"
#include "stdio.fh"
#include "mafdecls.fh"
#include "bas_exndcf_dec.fh"
#include "bas_ibs_dec.fh"
#include "int_nbf.fh"
c
c::functions
      logical int_chk_init
      integer int_nint_cart, int_nint
      external int_chk_init
      external int_nint_cart, int_nint
c::passed
      integer i_basis             ! [input] basis set handle for ish
      integer ish                 ! [input] i shell/contraction
      integer j_basis             ! [input] basis set handle for jsh
      integer jsh                 ! [input] j shell/contraction
c...     translation vectors are in fractional coordinates 
      double precision R(3)       ! [input] translation vec on j cont.
      integer lval                ! [input] maximum lvalue for 
*.......................................... multipole integrals 
*.......................................... in this batch
      double precision centerl(3) ! [input] coordinates of multipole
      integer lscr                ! [input] length of scratch array
      double precision scr(lscr)  ! [input] scratch array
      integer lmpint              ! [input] length of multipole 
*.......................................... integrals array
      double precision MP(lmpint) ! [output] multipole integrals
      integer num_mpint           ! [output] number of multipole integrals
c::local      
      logical shells_ok
      integer ibas, Li, i_prim, i_gen, i_iexp, i_icfp, i_cent, i_geom
      integer jbas, Lj, j_prim, j_gen, j_iexp, j_icfp, j_cent, j_geom
      integer ucont
      integer l_int, ij_int, ij_int_x, num_int
      integer lpole
      double precision xyz_new(3)
      logical inline_chk_sh      
c
      integer WarnP
      save WarnP
      data WarnP /0/
c
#include "bas_exndcf_sfn.fh"
#include "bas_ibs_sfn.fh"
c
c... statement function for int_chk_sh
      inline_chk_sh(ibas,ish) =
     $     ((ish.gt.0) .and. (ish.le.ncont_tot_gb(ibas)))
c
c check initialization
c      
      if (.not.int_chk_init('intp_mpolel'))
     &       call errquit('intp_mpolel: int_init was not called' ,0,
     &          INT_ERR)
c
c  check if gencon/sp shells
c
      call int_nogencont_check(i_basis,'intp_mpolel:i_basis')
      call int_nogencont_check(j_basis,'intp_mpolel:j_basis')
      call int_nospshell_check(i_basis,'intp_mpolel:i_basis')
      call int_nospshell_check(j_basis,'intp_mpolel:j_basis')
c
      ibas = i_basis + BASIS_HANDLE_OFFSET
      jbas = j_basis + BASIS_HANDLE_OFFSET
c
      shells_ok = inline_chk_sh(ibas,ish)
      shells_ok = shells_ok .and. inline_chk_sh(jbas,jsh)
      if (.not. shells_ok)
     &       call errquit('intp_mpolel: invalid contraction/shell',0,
     &          INT_ERR)
c
***   set defNxyz such that it can handle the maximum multi-pole
c
      lpole = lval/4 + 1
      call defNxyz(lpole)
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
        write(luout,*)'intp_mpolel: WARNING: possible geometry',
     &      ' inconsistency'
        write(luout,*)'i_basis geometry handle:',i_geom
        write(luout,*)'j_basis geometry handle:',j_geom
        WarnP = 1
      endif
c
      call intp_txyz(j_cent,j_geom,R,xyz_new)
c
      if (i_gen.gt.1 .or. j_gen.gt.1) then
        write(luout,*)
     &      ' hf3ois does not handle general contractions yet'
        call errquit('intp_mpolel: general contraction error ',911,
     &         BASIS_ERR)
      endif
c
      l_int    = (lval+1)*(lval+2)/2
      ij_int   = int_nint(i_basis, ish, j_basis, jsh, 0,0, 0,0)
      ij_int_x = int_nint_cart(i_basis, ish, j_basis, jsh, 0,0, 0,0)
      if ((num_int+l_int*ij_int_x).gt.lmpint) then
        write(luout,*)' intp_mpolel: lmpint  = ',lmpint
        write(luout,*)' intp_mpolel: (num_int+l_int*ij_int_x) = ',
     &      (num_int+l_int*ij_int_x)
        call errquit('intp_mpolel: lmpint too small ',911, INT_ERR)
      endif
      num_int =  l_int*ij_int
      call hf3ois(
     &    coords(1,i_cent,i_geom),dbl_mb(mb_exndcf(i_iexp,ibas)),
     &    dbl_mb(mb_exndcf(i_icfp,ibas)),i_prim, Li,
     &    xyz_new,dbl_mb(mb_exndcf(j_iexp,jbas)),
     &    dbl_mb(mb_exndcf(j_icfp,jbas)),j_prim, Lj,
     &    centerl,DCexp,
     &    DCcoeff, 1,  lval,
c.....................TriDiag..DryRun
     &    MP,num_int,.false.,.false.,scr,lscr)
      num_mpint = num_int
      if (bas_spherical(ibas).or.bas_spherical(jbas)) then
        if (Li.eq.-1) i_gen = 1
        if (Lj.eq.-1) j_gen = 1
        call spcart_3ctran(MP,scr,lscr,
     &      int_nbf_x(Li),int_nbf_s(Li),Li,i_gen,bas_spherical(ibas),
     &      int_nbf_x(Lj),int_nbf_s(Lj),Lj,j_gen,bas_spherical(jbas),
     &      int_nbf_x(lval),int_nbf_x(lval),lval,1,.false.,
     &      .false.)
      endif

      end
