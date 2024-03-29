      SUBROUTINE OFFSET_ccsdtq_lr_alpha_16_20_5_1(l_a_offset,k_a_offset,
     &size)
C     $Id: offset_ccsdtq_lr_alpha_16_20_5_1.F,v 1.1 2007-10-29 02:26:58 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h2 h7 h8 h14 p5 p11 )_ytrb
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
      INTEGER h14b
      INTEGER p5b
      INTEGER p11b
      length = 0
      DO h2b = 1,noab
      DO h7b = h2b,noab
      DO h8b = h7b,noab
      DO h14b = 1,noab
      DO p5b = noab+1,noab+nvab
      DO p11b = p5b,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)
     & .eq. int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1)+int_mb(k_spin+p11
     &b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h7b-1),ieor(int_mb(
     &k_sym+h8b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+p5b-1),in
     &t_mb(k_sym+p11b-1)))))) .eq. ieor(irrep_y,irrep_trb)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1
     &)+int_mb(k_spin+h8b-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1)+
     &int_mb(k_spin+p11b-1).ne.12)) THEN
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
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lr_alpha_16_20_5_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h2b = 1,noab
      DO h7b = h2b,noab
      DO h8b = h7b,noab
      DO h14b = 1,noab
      DO p5b = noab+1,noab+nvab
      DO p11b = p5b,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)
     & .eq. int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1)+int_mb(k_spin+p11
     &b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h7b-1),ieor(int_mb(
     &k_sym+h8b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+p5b-1),in
     &t_mb(k_sym+p11b-1)))))) .eq. ieor(irrep_y,irrep_trb)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h7b-1
     &)+int_mb(k_spin+h8b-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1)+
     &int_mb(k_spin+p11b-1).ne.12)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p11b - noab - 1 + nvab * (p5b - noab - 1
     & + nvab * (h14b - 1 + noab * (h8b - 1 + noab * (h7b - 1 + noab * (
     &h2b - 1)))))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h2b-1) * int_mb(k_range+h7b-1) * int_
     &mb(k_range+h8b-1) * int_mb(k_range+h14b-1) * int_mb(k_range+p5b-1)
     & * int_mb(k_range+p11b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
