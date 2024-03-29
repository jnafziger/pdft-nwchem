      SUBROUTINE eomccsdtq_y1_19_2_5_1(d_a,k_a_offset,d_c,k_c_offset)
C     $Id: eomccsdtq_y1_19_2_5_1.F,v 1.2 2005-12-19 19:04:06 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h10 p18 p4 p8 )_v + = 1 * v ( h10 p18 p4 p8 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_a
      INTEGER k_a_offset
      INTEGER d_c
      INTEGER k_c_offset
      INTEGER NXTVAL
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER h10b
      INTEGER p18b
      INTEGER p4b
      INTEGER p8b
      INTEGER dimc
      INTEGER h10b_1
      INTEGER p18b_1
      INTEGER p4b_1
      INTEGER p8b_1
      INTEGER dim_common
      INTEGER dima_sort
      INTEGER dima
      INTEGER l_a_sort
      INTEGER k_a_sort
      INTEGER l_a
      INTEGER k_a
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h10b = 1,noab
      DO p18b = noab+1,noab+nvab
      DO p4b = noab+1,noab+nvab
      DO p8b = p4b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h10b-1)+int_mb(k_spin+p18b
     &-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p8b-1).ne.8)) THEN
      IF (int_mb(k_spin+h10b-1)+int_mb(k_spin+p18b-1) .eq. int_mb(k_spin
     &+p4b-1)+int_mb(k_spin+p8b-1)) THEN
      IF (ieor(int_mb(k_sym+h10b-1),ieor(int_mb(k_sym+p18b-1),ieor(int_m
     &b(k_sym+p4b-1),int_mb(k_sym+p8b-1)))) .eq. irrep_v) THEN
      dimc = int_mb(k_range+h10b-1) * int_mb(k_range+p18b-1) * int_mb(k_
     &range+p4b-1) * int_mb(k_range+p8b-1)
      CALL TCE_RESTRICTED_4(h10b,p18b,p4b,p8b,h10b_1,p18b_1,p4b_1,p8b_1)
      dim_common = 1
      dima_sort = int_mb(k_range+h10b-1) * int_mb(k_range+p18b-1) * int_
     &mb(k_range+p4b-1) * int_mb(k_range+p8b-1)
      dima = dim_common * dima_sort
      IF (dima .gt. 0) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_19_2_5_1',0,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y1_19_2_5_1',1,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p8b_1
     & - 1 + (noab+nvab) * (p4b_1 - 1 + (noab+nvab) * (p18b_1 - 1 + (noa
     &b+nvab) * (h10b_1 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+p4b-1),int_mb(k_range+p8b-
     &1),4,3,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y1_19_2_5_1',2
     &,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y1_19_2_5_1',3,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_a_sort),dbl_mb(k_c),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p4b-1),int_mb(k_range+p18b-1),int_mb(k_range+h10b-
     &1),4,3,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p8b -
     & noab - 1 + nvab * (p4b - noab - 1 + nvab * (p18b - noab - 1 + nva
     &b * (h10b - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y1_19_2_5_1',4
     &,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y1_19_2_5
     &_1',5,MA_ERR)
      END IF
      END IF
      END IF
      END IF
      next = NXTVAL(nprocs)
      END IF
      count = count + 1
      END DO
      END DO
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
