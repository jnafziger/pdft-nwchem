      SUBROUTINE OFFSET_eomccsdtq_x3_11_1_2_1(l_a_offset,k_a_offset,size
     &)
C     $Id: OFFSET_eomccsdtq_x3_11_1_2_1.F,v 1.2 2005-12-19 19:03:31 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h8 h11 h1 p10 )_v
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
      INTEGER h8b
      INTEGER h11b
      INTEGER h1b
      INTEGER p10b
      length = 0
      DO h8b = 1,noab
      DO h11b = h8b,noab
      DO h1b = 1,noab
      DO p10b = noab+1,noab+nvab
      IF (int_mb(k_spin+h8b-1)+int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+
     &h1b-1)+int_mb(k_spin+p10b-1)) THEN
      IF (ieor(int_mb(k_sym+h8b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb
     &(k_sym+h1b-1),int_mb(k_sym+p10b-1)))) .eq. irrep_v) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h8b-1)+int_mb(k_spin+h11b-
     &1)+int_mb(k_spin+h1b-1)+int_mb(k_spin+p10b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('eomccsdtq_x3_11_1_2_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h8b = 1,noab
      DO h11b = h8b,noab
      DO h1b = 1,noab
      DO p10b = noab+1,noab+nvab
      IF (int_mb(k_spin+h8b-1)+int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+
     &h1b-1)+int_mb(k_spin+p10b-1)) THEN
      IF (ieor(int_mb(k_sym+h8b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb
     &(k_sym+h1b-1),int_mb(k_sym+p10b-1)))) .eq. irrep_v) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h8b-1)+int_mb(k_spin+h11b-
     &1)+int_mb(k_spin+h1b-1)+int_mb(k_spin+p10b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p10b - noab - 1 + nvab * (h1b - 1 + noab
     & * (h11b - 1 + noab * (h8b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h8b-1) * int_mb(k_range+h11b-1) * int
     &_mb(k_range+h1b-1) * int_mb(k_range+p10b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
