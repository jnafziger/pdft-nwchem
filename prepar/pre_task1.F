      logical function pre_task1(irtdb)
c
c $Id: pre_task1.F,v 1.6 2003-10-19 03:30:59 d3j191 Exp $
c
      implicit none
c
#include "rtdb.fh"
c
      logical scf,esp
      external scf,esp
c
      integer irtdb
      logical lstate
c
      lstate=rtdb_parallel(.true.)
c
      pre_task1=.false.
c
c      if(.not.rtdb_cput(irtdb,'scf:print',1,'none'))
c     + call md_abort('pre_task1: rtdb_cput failed',9999)
c
      if(scf(irtdb)) then
c
c      if(.not.rtdb_cput(irtdb,'esp:print',1,'none'))
c     + call md_abort('pre_task1: rtdb_cput failed',9999)
c
      if(esp(irtdb)) then
      pre_task1=.true.
      endif
      endif
c
      lstate=rtdb_parallel(.false.)
c
      return
      end
