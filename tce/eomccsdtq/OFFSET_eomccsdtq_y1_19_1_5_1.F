      SUBROUTINE OFFSET_eomccsdtq_y1_19_1_5_1(l_a_offset,k_a_offset,size
     &)
C     $Id: OFFSET_eomccsdtq_y1_19_1_5_1.F,v 1.2 2005-12-19 19:03:37 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h6 p18 p7 p8 )_v
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
      INTEGER p18b
      INTEGER p7b
      INTEGER p8b
      length = 0
      DO h6b = 1,noab
      DO p18b = noab+1,noab+nvab
      DO p7b = noab+1,noab+nvab
      DO p8b = p7b,noab+nvab
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+p18b-1) .eq. int_mb(k_spin+
     &p7b-1)+int_mb(k_spin+p8b-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+p18b-1),ieor(int_mb
     &(k_sym+p7b-1),int_mb(k_sym+p8b-1)))) .eq. irrep_v) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+p18b-
     &1)+int_mb(k_spin+p7b-1)+int_mb(k_spin+p8b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('eomccsdtq_y1_19_1_5_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h6b = 1,noab
      DO p18b = noab+1,noab+nvab
      DO p7b = noab+1,noab+nvab
      DO p8b = p7b,noab+nvab
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+p18b-1) .eq. int_mb(k_spin+
     &p7b-1)+int_mb(k_spin+p8b-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+p18b-1),ieor(int_mb
     &(k_sym+p7b-1),int_mb(k_sym+p8b-1)))) .eq. irrep_v) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+p18b-
     &1)+int_mb(k_spin+p7b-1)+int_mb(k_spin+p8b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p8b - noab - 1 + nvab * (p7b - noab - 1 
     &+ nvab * (p18b - noab - 1 + nvab * (h6b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h6b-1) * int_mb(k_range+p18b-1) * int
     &_mb(k_range+p7b-1) * int_mb(k_range+p8b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
