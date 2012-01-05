*
* $Id: pspw_stress.F,v 1.2 2004-11-29 16:05:21 bylaska Exp $
*

      logical function pspw_stress(rtdb)
      implicit none
      integer rtdb

#include "mafdecls.fh"
#include "rtdb.fh"

*     **** local variables ****
      logical numerical

*     **** external functions ****
      logical  cgsdv5,pspw_stress_numerical
      external cgsdv5,pspw_stress_numerical


      if (.not.
     >  rtdb_get(rtdb,'nwpw:stress_numerical',mt_log,1,numerical))
     >  numerical = .false.

      if (numerical) then
        pspw_stress = pspw_stress_numerical(rtdb)
      else
        pspw_stress = cgsdv5(rtdb,3)
      end if

      return
      end

