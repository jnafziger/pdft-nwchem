      SUBROUTINE OFFSET_ccsdt_lr_alpha_offdiag_15_25_2_1(l_a_offset,k_a_
     &offset,size)
C     $Id: offset_ccsdt_lr_alpha_offdiag_15_25_2_1.F,v 1.1 2007-08-11 01:26:00 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h7 h10 h14 p5 )_yt
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
      INTEGER h7b
      INTEGER h10b
      INTEGER h14b
      INTEGER p5b
      length = 0
      DO h7b = 1,noab
      DO h10b = h7b,noab
      DO h14b = 1,noab
      DO p5b = noab+1,noab+nvab
      IF (int_mb(k_spin+h7b-1)+int_mb(k_spin+h10b-1) .eq. int_mb(k_spin+
     &h14b-1)+int_mb(k_spin+p5b-1)) THEN
      IF (ieor(int_mb(k_sym+h7b-1),ieor(int_mb(k_sym+h10b-1),ieor(int_mb
     &(k_sym+h14b-1),int_mb(k_sym+p5b-1)))) .eq. ieor(irrep_y,irrep_t)) 
     &THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h7b-1)+int_mb(k_spin+h10b-
     &1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_15_25_2_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h7b = 1,noab
      DO h10b = h7b,noab
      DO h14b = 1,noab
      DO p5b = noab+1,noab+nvab
      IF (int_mb(k_spin+h7b-1)+int_mb(k_spin+h10b-1) .eq. int_mb(k_spin+
     &h14b-1)+int_mb(k_spin+p5b-1)) THEN
      IF (ieor(int_mb(k_sym+h7b-1),ieor(int_mb(k_sym+h10b-1),ieor(int_mb
     &(k_sym+h14b-1),int_mb(k_sym+p5b-1)))) .eq. ieor(irrep_y,irrep_t)) 
     &THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h7b-1)+int_mb(k_spin+h10b-
     &1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+p5b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p5b - noab - 1 + nvab * (h14b - 1 + noab
     & * (h10b - 1 + noab * (h7b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h7b-1) * int_mb(k_range+h10b-1) * int
     &_mb(k_range+h14b-1) * int_mb(k_range+p5b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
