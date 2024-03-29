      SUBROUTINE OFFSET_ccsdtq_lr_alpha_11_1(l_a_offset,k_a_offset,size)
C     $Id: offset_ccsdtq_lr_alpha_11_1.F,v 1.1 2007-10-29 02:26:31 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h10 p11 h12 p9 )_ytrbtra
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
      INTEGER h10b
      INTEGER p11b
      INTEGER h12b
      INTEGER p9b
      length = 0
      DO h10b = 1,noab
      DO p11b = noab+1,noab+nvab
      DO h12b = 1,noab
      DO p9b = noab+1,noab+nvab
      IF (int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b-1) .eq. int_mb(k_spin
     &+h12b-1)+int_mb(k_spin+p9b-1)) THEN
      IF (ieor(int_mb(k_sym+h10b-1),ieor(int_mb(k_sym+p11b-1),ieor(int_m
     &b(k_sym+h12b-1),int_mb(k_sym+p9b-1)))) .eq. ieor(irrep_y,ieor(irre
     &p_trb,irrep_tra))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b
     &-1)+int_mb(k_spin+h12b-1)+int_mb(k_spin+p9b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lr_alpha_11_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h10b = 1,noab
      DO p11b = noab+1,noab+nvab
      DO h12b = 1,noab
      DO p9b = noab+1,noab+nvab
      IF (int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b-1) .eq. int_mb(k_spin
     &+h12b-1)+int_mb(k_spin+p9b-1)) THEN
      IF (ieor(int_mb(k_sym+h10b-1),ieor(int_mb(k_sym+p11b-1),ieor(int_m
     &b(k_sym+h12b-1),int_mb(k_sym+p9b-1)))) .eq. ieor(irrep_y,ieor(irre
     &p_trb,irrep_tra))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b
     &-1)+int_mb(k_spin+h12b-1)+int_mb(k_spin+p9b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p9b - noab - 1 + nvab * (h12b - 1 + noab
     & * (p11b - noab - 1 + nvab * (h10b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h10b-1) * int_mb(k_range+p11b-1) * in
     &t_mb(k_range+h12b-1) * int_mb(k_range+p9b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
