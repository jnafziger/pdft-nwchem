      SUBROUTINE OFFSET_ccsdt_y_tr1_10_14_1(l_a_offset,k_a_offset,size)
C     $Id: OFFSET_ccsdt_y_tr1_10_14_1.F,v 1.1 2008-09-17 04:49:33 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h2 h9 h13 p7 )_yt
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
      INTEGER h9b
      INTEGER h13b
      INTEGER p7b
      length = 0
      DO h2b = 1,noab
      DO h9b = 1,noab
      DO h13b = 1,noab
      DO p7b = noab+1,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h9b-1) .eq. int_mb(k_spin+h
     &13b-1)+int_mb(k_spin+p7b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h9b-1),ieor(int_mb(
     &k_sym+h13b-1),int_mb(k_sym+p7b-1)))) .eq. ieor(irrep_y,irrep_t)) T
     &HEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h9b-1
     &)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p7b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdt_y_tr1_10_14_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h2b = 1,noab
      DO h9b = 1,noab
      DO h13b = 1,noab
      DO p7b = noab+1,noab+nvab
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h9b-1) .eq. int_mb(k_spin+h
     &13b-1)+int_mb(k_spin+p7b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h9b-1),ieor(int_mb(
     &k_sym+h13b-1),int_mb(k_sym+p7b-1)))) .eq. ieor(irrep_y,irrep_t)) T
     &HEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h9b-1
     &)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p7b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p7b - noab - 1 + nvab * (h13b - 1 + noab
     & * (h9b - 1 + noab * (h2b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h2b-1) * int_mb(k_range+h9b-1) * int_
     &mb(k_range+h13b-1) * int_mb(k_range+p7b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
