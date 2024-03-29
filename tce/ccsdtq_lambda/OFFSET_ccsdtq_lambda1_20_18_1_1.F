      SUBROUTINE OFFSET_ccsdtq_lambda1_20_18_1_1(l_a_offset,k_a_offset,s
     &ize)
C     $Id: OFFSET_ccsdtq_lambda1_20_18_1_1.F,v 1.3 2005-12-16 22:42:17 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h6 h10 h14 h16 )_vt
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
      INTEGER h6b
      INTEGER h10b
      INTEGER h14b
      INTEGER h16b
      length = 0
      DO h6b = 1,noab
      DO h10b = h6b,noab
      DO h14b = 1,noab
      DO h16b = h14b,noab
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+h10b-1) .eq. int_mb(k_spin+
     &h14b-1)+int_mb(k_spin+h16b-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+h10b-1),ieor(int_mb
     &(k_sym+h14b-1),int_mb(k_sym+h16b-1)))) .eq. ieor(irrep_v,irrep_t))
     & THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+h10b-
     &1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h16b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lambda1_20_18_1_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h6b = 1,noab
      DO h10b = h6b,noab
      DO h14b = 1,noab
      DO h16b = h14b,noab
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+h10b-1) .eq. int_mb(k_spin+
     &h14b-1)+int_mb(k_spin+h16b-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+h10b-1),ieor(int_mb
     &(k_sym+h14b-1),int_mb(k_sym+h16b-1)))) .eq. ieor(irrep_v,irrep_t))
     & THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+h10b-
     &1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h16b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = h16b - 1 + noab * (h14b - 1 + noab * (h1
     &0b - 1 + noab * (h6b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h6b-1) * int_mb(k_range+h10b-1) * int
     &_mb(k_range+h14b-1) * int_mb(k_range+h16b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
