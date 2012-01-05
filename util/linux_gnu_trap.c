#include <fpu_control.h>
/*---------------------------------------------------------*\
$Id: linux_gnu_trap.c,v 1.1 1999-07-01 09:30:39 d3e129 Exp $

  This routine turns on floating point traps for
  1) Illegal instructions
  2) Divide by zero
  3) and Floating Point Overflow 
\*---------------------------------------------------------*/
static void __attribute__ ((constructor))
     trapfpe ()
{
    __setfpucw (_FPU_DEFAULT &
      ~(_FPU_MASK_IM | _FPU_MASK_ZM | _FPU_MASK_OM));
}
