c $Id: intbd_2e4c.F,v 1.14 2004-12-03 22:34:31 bert Exp $
*
      logical function intbd_2e4c(brain, icl, jcl, ketin, kcl, lcl,
     &     num_q, q4, use_q4, zerotol, canonicalize,
     &     ilab, jlab, klab, llab, eri,
     &     l_erilab, nint, lscr, scr)
      implicit none
#include "numb_qP.fh"
#include "nwc_const.fh"
#include "basP.fh"
#include "basdeclsP.fh"
#include "geobasmapP.fh"
#include "stdio.fh"
c::functions
      logical intbd_nw_2e4c
      external intbd_nw_2e4c
c::passed
c:tex-\begin{verbatim}
      integer brain             ! [input]  basis set handle for bra 
      integer ketin             ! [input]  basis set handle for ket 
      integer num_q             ! [input]  number of quartets input
      integer icl(num_q)        ! [input]  i-contraction quartet labels
      integer jcl(num_q)        ! [input]  j-contraction quartet labels
      integer kcl(num_q)        ! [input]  k-contraction quartet labels
      integer lcl(num_q)        ! [input]  l-contraction quartet labels
      logical use_q4            ! [input]  logical for use of q4
      double precision q4(num_q) ! [input] symmetry prefactors for ints
*     
      integer l_erilab          ! [input]  length of eri and label arrays
      integer ilab(l_erilab)    ! [output] integral labels for ``i'' 
      integer jlab(l_erilab)    ! [output] integral labels for ``j'' 
      integer klab(l_erilab)    ! [output] integral labels for ``k'' 
      integer llab(l_erilab)    ! [output] integral labels for ``l'' 
      integer nint              ! [output] number of integrals returned
      double precision eri(12,l_erilab) ! [output] integral values
      integer lscr              ! [input] length of scratch array
      double precision scr(lscr) ! [input] scratch array
      double precision zerotol  ! [input] zero integral threshold
      logical canonicalize      ! [input] Canonicalize integral labels?
c:tex-\end{verbatim}
      
c::local
      double precision roff(3)
c
      intbd_2e4c = .false.
      if (num_q.eq.0) then
        nint = 0
        return
      endif
      if (txs_b2e4c) then
        call texas_hf2_m(
     &      brain, icl(num_q_start), jcl(num_q_start),
     &      ketin, kcl(num_q_start), lcl(num_q_start), 
     &      num_q-num_q_start+1,
     &      q4(num_q_start), use_q4,
     &      roff,roff,roff,roff,.false.,
     &      eri,l_erilab, ilab, jlab, klab, llab, nint, .true.,
     &      more_ints_txs, scr, lscr, zerotol,'der1_int')
        intbd_2e4c = more_ints_txs
      else
        intbd_2e4c = intbd_nw_2e4c(
     &      brain, icl, jcl, ketin, kcl, lcl,
     &      num_q, q4, use_q4, zerotol, canonicalize,
     &      ilab, jlab, klab, llab, eri,
     &      l_erilab, nint, lscr, scr)
        return
      endif
c
      end
      logical function intbd_nw_2e4c(
     &    brain, icl, jcl, ketin, kcl, lcl,
     &    num_q, q4, use_q4, zerotol, canonicalize,
     &     ilab, jlab, klab, llab, eri,
     &     l_erilab, nint, lscr, scr)
      implicit none
#include "errquit.fh"
#include "stdio.fh"
#include "bas.fh"
#include "nwc_const.fh"
#include "basP.fh"
#include "numb_qP.fh"
c::functions
      integer int_nint_cart
      external int_nint_cart
c::   passed
c:tex-\begin{verbatim}
      integer brain             ! [input]  basis set handle for bra 
      integer ketin             ! [input]  basis set handle for ket 
      integer num_q             ! [input]  number of quartets input
      integer icl(num_q)        ! [input]  i-contraction quartet labels
      integer jcl(num_q)        ! [input]  j-contraction quartet labels
      integer kcl(num_q)        ! [input]  k-contraction quartet labels
      integer lcl(num_q)        ! [input]  l-contraction quartet labels
      logical use_q4            ! [input]  logical for use of q4
      double precision q4(num_q) ! [input] symmetry prefactors for ints
*     
      integer l_erilab          ! [input]  length of eri and label arrays
      integer ilab(l_erilab)    ! [output] integral labels for ``i'' 
      integer jlab(l_erilab)    ! [output] integral labels for ``j'' 
      integer klab(l_erilab)    ! [output] integral labels for ``k'' 
      integer llab(l_erilab)    ! [output] integral labels for ``l'' 
      integer nint              ! [output] number of integrals returned
      double precision eri(12,l_erilab) ! [output] integral values
      integer lscr              ! [input] length of scratch array
      double precision scr(lscr) ! [input] scratch array
      double precision zerotol  ! [input] zero integral threshold
      logical canonicalize      ! [input] Canonicalize integral labels?
c:tex-\end{verbatim}
*
c:local
      integer i_q 
      integer i_scr_ptr
      integer newlscr
      integer idatom(4)
      integer nint_s
      integer numint
      integer ilo, jlo, klo, llo
      integer ihi, jhi, khi, lhi
*
c
      intbd_nw_2e4c = .true.
*
      if (num_q_start.eq.num_q_last) then
         write(luout,*)' l_erilab: too small ',l_erilab
         call errquit(' intbd_nw_2e4c: infinite blocking loop ',911,
     &              INT_ERR)
      endif
c
*... only do one quartet of derivative integrals at a time!!
      i_q = num_q_start
      num_q_last = num_q_start
*......
      nint_s = 1
*
      if (.not.bas_cn2bfr(brain,icl(i_q),ilo,ihi))
     &    call errquit(' intbd_nw_2e4c: cn2bfr failed for ish',911,
     &            INT_ERR)
      nint_s = nint_s*(ihi-ilo+1)       ! i partial block size
*
      if (.not.bas_cn2bfr(brain,jcl(i_q),jlo,jhi))
     &    call errquit(' intbd_nw_2e4c: cn2bfr failed for jsh',911,
     &          INT_ERR)
      nint_s = nint_s*(jhi-jlo+1)       ! j partial block size
*
      if (.not.bas_cn2bfr(brain,kcl(i_q),klo,khi))
     &    call errquit(' intbd_nw_2e4c: cn2bfr failed for ksh',911,
     &                  INT_ERR)
      nint_s = nint_s*(khi-klo+1)       ! k partial block size
*
      if (.not.bas_cn2bfr(brain,lcl(i_q),llo,lhi))
     &    call errquit(' intbd_nw_2e4c: cn2bfr failed for lsh',911,
     &          INT_ERR)
      nint_s = nint_s*(lhi-llo+1)       ! l partial block size
*......

      if (nint_s.gt.l_erilab) then
        write(luout,*)' nint_s    = ',nint_s
        write(luout,*)' l_erilab  = ',l_erilab
        call errquit(' intbd_nw_2e4c: buffer size too small ',911,
     &            INT_ERR)
      endif
      numint = int_nint_cart(                    ! get size of cartesian block
     &    brain,icl(i_q),brain,jcl(i_q),
     &    ketin,kcl(i_q),ketin,lcl(i_q))
      numint = numint*12
      i_scr_ptr = numint + 1
      newlscr   = lscr - numint
      if (newlscr .lt. 0) then
        write(luout,*)' newlscr too small      :',newlscr
        write(luout,*)' lscr                   :',lscr
        write(luout,*)' numint                 :',(numint/12)
        write(luout,*)' numint spherical       :',nint_s
        write(luout,*)' numint grad            :',numint
        write(luout,*)' numint grad spherical  :',(nint_s*12)
        write(luout,*)' i bf size is ',(ihi-ilo+1)
        write(luout,*)' j bf size is ',(jhi-jlo+1)
        write(luout,*)' k bf size is ',(khi-klo+1)
        write(luout,*)' l bf size is ',(lhi-llo+1)
        call errquit('intbd_nw_2e4c: fatal error',911, INT_ERR)
      endif
*
* use memory copy instead of first part of scratch.  Otherwise scratch is 
* way to big to do derivativeswith sphericals
*
      call intd_2e4c(
     &    brain,icl(i_q),jcl(i_q),
     &    ketin,kcl(i_q),lcl(i_q),
     &    lscr,scr,
     &    numint,eri,idatom)
      call dcopy (numint,eri,1,scr,1)
      if (nint_s.gt.numint) then
        write(luout,*)' spherical/real size larger than cartesean size'
        write(luout,*)' nint_s = ',nint_s
        write(luout,*)' numint = ',numint
        call errquit('intbd_nw_2e4c: fatal error ',911, INT_ERR)
      endif
* scr has integral derivatives in nwchem order (nint_s,3,4)      
      nint = 0
      call intbd_nw_label_copy(scr,eri,nint_s,nint,idatom,
     &    ilo,ihi,jlo,jhi,klo,khi,llo,lhi,
     &    ilab,jlab,klab,llab,
     &    zerotol,canonicalize)
      if (use_q4.and.nint.gt.0) then
        call dscal((nint*12),q4(i_q),eri,1)
      endif
      if (i_q.eq.num_q) then
        num_q_start = 1
        intbd_nw_2e4c = .false.
      else
        num_q_start = i_q + 1
      endif
c
      end
      subroutine intbd_nw_label_copy(eri_nworder,eri,nint_s,nint,idatom,
     &    ilo,ihi,jlo,jhi,klo,khi,llo,lhi,
     &    ilab,jlab,klab,llab,
     &    zerotol,canonicalize)
      implicit none
c::passed
      integer nint_s
      integer nint
      integer idatom(4)
      integer ilo, jlo, klo, llo
      integer ihi, jhi, khi, lhi
      integer ilab(nint_s)
      integer jlab(nint_s)
      integer klab(nint_s)
      integer llab(nint_s)
      double precision zerotol
      logical canonicalize
      double precision eri_nworder(llo:lhi,klo:khi,jlo:jhi,ilo:ihi,3,4)
      double precision eri(3,4,nint_s)
c::local
      integer i, xyz, ii, jj, kk, ll
      double precision val_max
      double precision vals(3,4)
      integer numgt1
*
      call dcopy((12*nint_s),0.0d00,0,eri,1)
      nint = 0
      numgt1 = 0
      do i = 1,4
        if (idatom(i).ge.1) numgt1 = numgt1+1
      enddo
      if (numgt1.eq.0) return
*
      do i = 1,4
        if (idatom(i).lt.1) then   ! ensure that unused buffers from idatom are zero
          call dcopy((3*nint_s),0.0d00,0,
     &        eri_nworder(llo,klo,jlo,ilo,1,i),1)
        endif
      enddo
      do ii = ilo,ihi
        do jj = jlo,jhi
          do kk = klo,khi
            do ll = llo,lhi
              val_max = 0.0d00
              do i = 1,4
                do xyz = 1,3
*assume: memory copy is cheaper than 2 memory access with stride nint_s ?
*check this out
                  vals(xyz,i) = eri_nworder(ll,kk,jj,ii,xyz,i)
                  val_max = max(val_max,abs(vals(xyz,i)))
                enddo
              enddo
              if (val_max.gt.zerotol) then
                nint = nint + 1
                if (canonicalize) then
                  call int_canon(
     &                ii,        jj,        kk,        ll,
     &                ilab(nint),jlab(nint),klab(nint),llab(nint))
                else
                  ilab(nint) = ii
                  jlab(nint) = jj
                  klab(nint) = kk
                  llab(nint) = ll
                endif
                do i = 1,4
                  do xyz = 1,3
                    eri(xyz,i,nint) = vals(xyz,i)
                  enddo
                enddo
              endif
            enddo
          enddo
        enddo
      enddo
*
      end
