      SUBROUTINE OFFSET_ccsdtq_lambda1_9_6_1(l_a_offset,k_a_offset,size)
C     $Id: OFFSET_ccsdtq_lambda1_9_6_1.F,v 1.3 2005-12-16 22:42:18 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h11 h14 h13 p10 )_yt
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
      INTEGER h11b
      INTEGER h14b
      INTEGER h13b
      INTEGER p10b
      length = 0
      DO h11b = 1,noab
      DO h14b = h11b,noab
      DO h13b = 1,noab
      DO p10b = noab+1,noab+nvab
      IF (int_mb(k_spin+h11b-1)+int_mb(k_spin+h14b-1) .eq. int_mb(k_spin
     &+h13b-1)+int_mb(k_spin+p10b-1)) THEN
      IF (ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_m
     &b(k_sym+h13b-1),int_mb(k_sym+p10b-1)))) .eq. ieor(irrep_y,irrep_t)
     &) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h11b-1)+int_mb(k_spin+h14b
     &-1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p10b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lambda1_9_6_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h11b = 1,noab
      DO h14b = h11b,noab
      DO h13b = 1,noab
      DO p10b = noab+1,noab+nvab
      IF (int_mb(k_spin+h11b-1)+int_mb(k_spin+h14b-1) .eq. int_mb(k_spin
     &+h13b-1)+int_mb(k_spin+p10b-1)) THEN
      IF (ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_m
     &b(k_sym+h13b-1),int_mb(k_sym+p10b-1)))) .eq. ieor(irrep_y,irrep_t)
     &) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h11b-1)+int_mb(k_spin+h14b
     &-1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p10b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p10b - noab - 1 + nvab * (h13b - 1 + noa
     &b * (h14b - 1 + noab * (h11b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h11b-1) * int_mb(k_range+h14b-1) * in
     &t_mb(k_range+h13b-1) * int_mb(k_range+p10b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
