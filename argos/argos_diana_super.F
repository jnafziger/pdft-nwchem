      subroutine argos_diana_super()
c
c $Id: argos_diana_super.F,v 1.5 2007-03-14 16:17:48 d3j191 Exp $
c
      implicit none
c
#include "msgids.fh"
#include "global.fh"
#include "mafdecls.fh"
#include "argos_diana_common.fh"
c
      call ga_distribution(ga_trj,me,il,ih,jl,jh)
      call ga_access(ga_trj,il,ih,jl,jh,ndx,ld)
c
      if(.not.ma_verify_allocator_stuff()) print*,'Oopsi 3'
c
      call argos_diana_supimp(dbl_mb(ndx))
c
      return
      end
