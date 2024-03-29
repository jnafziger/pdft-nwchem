      SUBROUTINE OFFSET_eomccsdtq_y1_13_8_1(l_a_offset,k_a_offset,size)
C     $Id: OFFSET_eomccsdtq_y1_13_8_1.F,v 1.2 2005-12-19 19:03:36 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h2 h7 h8 h9 h16 p3 p4 p5 )_yt
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
      INTEGER h7b
      INTEGER h8b
      INTEGER h9b
      INTEGER h16b
      INTEGER p3b
      INTEGER p4b
      INTEGER p5b
      length = 0
      DO h2b = 1,noab
      DO h7b = 1,noab
      DO h8b = h7b,noab
      DO h9b = h8b,noab
      DO h16b = 1,noab
      DO p3b = noab+1,noab+nvab
      DO p4b = p3b,noab+nvab
      DO p5b = p4b,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)
     &+int_mb(k_spin+h9b-1) .eq. int_mb(k_spin+h16b-1)+int_mb(k_spin+p3b
     &-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h7b-1),ieor(int_mb(
     &k_sym+h8b-1),ieor(int_mb(k_sym+h9b-1),ieor(int_mb(k_sym+h16b-1),ie
     &or(int_mb(k_sym+p3b-1),ieor(int_mb(k_sym+p4b-1),int_mb(k_sym+p5b-1
     &)))))))) .eq. ieor(irrep_y,irrep_t)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1
     &)+int_mb(k_spin+h8b-1)+int_mb(k_spin+h9b-1)+int_mb(k_spin+h16b-1)+
     &int_mb(k_spin+p3b-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1).ne.
     &16)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('eomccsdtq_y1_13_8_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h2b = 1,noab
      DO h7b = 1,noab
      DO h8b = h7b,noab
      DO h9b = h8b,noab
      DO h16b = 1,noab
      DO p3b = noab+1,noab+nvab
      DO p4b = p3b,noab+nvab
      DO p5b = p4b,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)
     &+int_mb(k_spin+h9b-1) .eq. int_mb(k_spin+h16b-1)+int_mb(k_spin+p3b
     &-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h7b-1),ieor(int_mb(
     &k_sym+h8b-1),ieor(int_mb(k_sym+h9b-1),ieor(int_mb(k_sym+h16b-1),ie
     &or(int_mb(k_sym+p3b-1),ieor(int_mb(k_sym+p4b-1),int_mb(k_sym+p5b-1
     &)))))))) .eq. ieor(irrep_y,irrep_t)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1
     &)+int_mb(k_spin+h8b-1)+int_mb(k_spin+h9b-1)+int_mb(k_spin+h16b-1)+
     &int_mb(k_spin+p3b-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1).ne.
     &16)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p5b - noab - 1 + nvab * (p4b - noab - 1 
     &+ nvab * (p3b - noab - 1 + nvab * (h16b - 1 + noab * (h9b - 1 + no
     &ab * (h8b - 1 + noab * (h7b - 1 + noab * (h2b - 1)))))))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h2b-1) * int_mb(k_range+h7b-1) * int_
     &mb(k_range+h8b-1) * int_mb(k_range+h9b-1) * int_mb(k_range+h16b-1)
     & * int_mb(k_range+p3b-1) * int_mb(k_range+p4b-1) * int_mb(k_range+
     &p5b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
