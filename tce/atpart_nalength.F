      SUBROUTINE atpart_nalength
C     $Id: atpart_nalength.F,v 1.2 2008-01-14 15:20:32 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "bas.fh"
#include "errquit.fh"
#include "tce_main.fh"
      INTEGER ix,i,length
      INTEGER mu,mu_lo,mu_hi,mu_range
c *** debug ***
      logical nodezero
      nodezero=(ga_nodeid().eq.0)
c *************
c
c  Can be used multiple times in tce_energy
      do i=1,200
       nalength(i) = 0
       a2length(i) = 0
      enddo
c
      length = 0 !current length of a given block (lenght<= imaxsize)
      ix     = 1 ! number of block
      a2length(ix)=0
      do mu = 1,nshells
          if (.not.bas_cn2bfr(ao_bas_han,mu,mu_lo,mu_hi))
     1    call errquit('tce_ao2e: basis fn range problem 1',0,
     2    BASIS_ERR)
          mu_range = mu_hi - mu_lo + 1
          length = length + mu_range
          if(length.gt.imaxsize) then
           nalength(ix)=length
           atpart =  ix
           ix=ix+1
           a2length(ix)=mu
           length = 0
          end if  
      enddo  !loop over mu-shells
c
      if(length.gt.0) then
        nalength(ix)=length
        a2length(ix+1)=nshells
        atpart=ix
      end if
      return
      end 

