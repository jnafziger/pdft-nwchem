      SUBROUTINE OFFSET_ccsdt_lr_alpha2_9_22_4_1(l_a_offset,k_a_offset,s
     &ize)
C     $Id: OFFSET_ccsdt_lr_alpha2_9_22_4_1.F,v 1.1 2008-09-17 03:17:49 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h2 h4 h14 h15 )_ytra
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
      INTEGER h2b
      INTEGER h4b
      INTEGER h14b
      INTEGER h15b
      length = 0
      DO h2b = 1,noab
      DO h4b = h2b,noab
      DO h14b = 1,noab
      DO h15b = h14b,noab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1) .eq. int_mb(k_spin+h
     &14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. ieor(irrep_y,irrep_tra)
     &) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1
     &)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdt_lr_alpha2_9_22_4_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h2b = 1,noab
      DO h4b = h2b,noab
      DO h14b = 1,noab
      DO h15b = h14b,noab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1) .eq. int_mb(k_spin+h
     &14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. ieor(irrep_y,irrep_tra)
     &) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1
     &)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = h15b - 1 + noab * (h14b - 1 + noab * (h4
     &b - 1 + noab * (h2b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h2b-1) * int_mb(k_range+h4b-1) * int_
     &mb(k_range+h14b-1) * int_mb(k_range+h15b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
