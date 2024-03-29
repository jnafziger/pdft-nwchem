      SUBROUTINE OFFSET_ccsdt_lr_beta_4_1_1(l_a_offset,k_a_offset,size)
C     $Id: OFFSET_ccsdt_lr_beta_4_1_1.F,v 1.1 2008-09-17 04:40:18 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p3 h2 )_vtrctratrb
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER p3b
      INTEGER h2b
      length = 0
      DO p3b = noab+1,noab+nvab
      DO h2b = 1,noab
      IF (int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h2b-1)) THEN
      IF (ieor(int_mb(k_sym+p3b-1),int_mb(k_sym+h2b-1)) .eq. ieor(irrep_
     &v,ieor(irrep_trc,ieor(irrep_tra,irrep_trb)))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p3b-1)+int_mb(k_spin+h2b-1
     &).ne.4)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdt_lr_beta_4_1_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO p3b = noab+1,noab+nvab
      DO h2b = 1,noab
      IF (int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h2b-1)) THEN
      IF (ieor(int_mb(k_sym+p3b-1),int_mb(k_sym+h2b-1)) .eq. ieor(irrep_
     &v,ieor(irrep_trc,ieor(irrep_tra,irrep_trb)))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p3b-1)+int_mb(k_spin+h2b-1
     &).ne.4)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = h2b - 1 + noab * (p3b - noab - 1)
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+p3b-1) * int_mb(k_range+h2b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      RETURN
      END
