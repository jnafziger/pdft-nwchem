      SUBROUTINE OFFSET_ccsdtq_lr_alpha_15_4_2_1(l_a_offset,k_a_offset,s
     &ize)
C     $Id: offset_ccsdtq_lr_alpha_15_4_2_1.F,v 1.1 2007-10-29 02:26:52 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h9 h11 h16 p8 )_yt
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
      INTEGER h9b
      INTEGER h11b
      INTEGER h16b
      INTEGER p8b
      length = 0
      DO h9b = 1,noab
      DO h11b = h9b,noab
      DO h16b = 1,noab
      DO p8b = noab+1,noab+nvab
      IF (int_mb(k_spin+h9b-1)+int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+
     &h16b-1)+int_mb(k_spin+p8b-1)) THEN
      IF (ieor(int_mb(k_sym+h9b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb
     &(k_sym+h16b-1),int_mb(k_sym+p8b-1)))) .eq. ieor(irrep_y,irrep_t)) 
     &THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h9b-1)+int_mb(k_spin+h11b-
     &1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+p8b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lr_alpha_15_4_2_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h9b = 1,noab
      DO h11b = h9b,noab
      DO h16b = 1,noab
      DO p8b = noab+1,noab+nvab
      IF (int_mb(k_spin+h9b-1)+int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+
     &h16b-1)+int_mb(k_spin+p8b-1)) THEN
      IF (ieor(int_mb(k_sym+h9b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb
     &(k_sym+h16b-1),int_mb(k_sym+p8b-1)))) .eq. ieor(irrep_y,irrep_t)) 
     &THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h9b-1)+int_mb(k_spin+h11b-
     &1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+p8b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p8b - noab - 1 + nvab * (h16b - 1 + noab
     & * (h11b - 1 + noab * (h9b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h9b-1) * int_mb(k_range+h11b-1) * int
     &_mb(k_range+h16b-1) * int_mb(k_range+p8b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
