      SUBROUTINE ccsdtq_lambda1_8_3_1(d_a,k_a_offset,d_c,k_c_offset)
C     $Id: ccsdtq_lambda1_8_3_1.F,v 1.3 2005-12-16 22:42:30 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( p14 p15 h13 p3 )_v + = 1 * v ( p14 p15 h13 p3 )_v
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
      INTEGER p14b
      INTEGER p15b
      INTEGER h13b
      INTEGER p3b
      INTEGER dimc
      INTEGER p14b_1
      INTEGER p15b_1
      INTEGER h13b_1
      INTEGER p3b_1
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
      DO p14b = noab+1,noab+nvab
      DO p15b = p14b,noab+nvab
      DO h13b = 1,noab
      DO p3b = noab+1,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p14b-1)+int_mb(k_spin+p15b
     &-1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p3b-1).ne.8)) THEN
      IF (int_mb(k_spin+p14b-1)+int_mb(k_spin+p15b-1) .eq. int_mb(k_spin
     &+h13b-1)+int_mb(k_spin+p3b-1)) THEN
      IF (ieor(int_mb(k_sym+p14b-1),ieor(int_mb(k_sym+p15b-1),ieor(int_m
     &b(k_sym+h13b-1),int_mb(k_sym+p3b-1)))) .eq. irrep_v) THEN
      dimc = int_mb(k_range+p14b-1) * int_mb(k_range+p15b-1) * int_mb(k_
     &range+h13b-1) * int_mb(k_range+p3b-1)
      CALL TCE_RESTRICTED_4(p14b,p15b,h13b,p3b,p14b_1,p15b_1,h13b_1,p3b_
     &1)
      dim_common = 1
      dima_sort = int_mb(k_range+p14b-1) * int_mb(k_range+p15b-1) * int_
     &mb(k_range+h13b-1) * int_mb(k_range+p3b-1)
      dima = dim_common * dima_sort
      IF (dima .gt. 0) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_8_3_1',0,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_lambda1_8_3_1',1,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p3b_1
     & - 1 + (noab+nvab) * (h13b_1 - 1 + (noab+nvab) * (p15b_1 - 1 + (no
     &ab+nvab) * (p14b_1 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p15b-1),int_mb(k_range+h13b-1),int_mb(k_range+p3b
     &-1),4,3,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_lambda1_8_3_1',2,
     &MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_lambda1_8_3_1',3,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_a_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+p15b-1),int_mb(k_range+p14b
     &-1),4,3,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
     & noab - 1 + nvab * (h13b - 1 + noab * (p15b - noab - 1 + nvab * (p
     &14b - noab - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_lambda1_8_3_1',4,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_lambda1_8_3_
     &1',5,MA_ERR)
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
