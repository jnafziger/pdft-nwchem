      SUBROUTINE ccsdtq_lambda1_8_7_3(d_a,k_a_offset,d_b,k_b_offset,d_c,
     &k_c_offset)
C     $Id: ccsdtq_lambda1_8_7_3.F,v 1.3 2005-12-16 22:42:30 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h6 p15 h13 p4 )_vt + = -1/2 * Sum ( h10 p8 ) * t ( p8 p15 h10 h13 )_t * v ( h6 h10 p4 p8 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_a
      INTEGER k_a_offset
      INTEGER d_b
      INTEGER k_b_offset
      INTEGER d_c
      INTEGER k_c_offset
      INTEGER NXTVAL
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p15b
      INTEGER h6b
      INTEGER h13b
      INTEGER p4b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p8b
      INTEGER h10b
      INTEGER p15b_1
      INTEGER p8b_1
      INTEGER h13b_1
      INTEGER h10b_1
      INTEGER h6b_2
      INTEGER h10b_2
      INTEGER p4b_2
      INTEGER p8b_2
      INTEGER dim_common
      INTEGER dima_sort
      INTEGER dima
      INTEGER dimb_sort
      INTEGER dimb
      INTEGER l_a_sort
      INTEGER k_a_sort
      INTEGER l_a
      INTEGER k_a
      INTEGER l_b_sort
      INTEGER k_b_sort
      INTEGER l_b
      INTEGER k_b
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p15b = noab+1,noab+nvab
      DO h6b = 1,noab
      DO h13b = 1,noab
      DO p4b = noab+1,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+p15b-
     &1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+p4b-1).ne.8)) THEN
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+p15b-1) .eq. int_mb(k_spin+
     &h13b-1)+int_mb(k_spin+p4b-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+p15b-1),ieor(int_mb
     &(k_sym+h13b-1),int_mb(k_sym+p4b-1)))) .eq. ieor(irrep_v,irrep_t)) 
     &THEN
      dimc = int_mb(k_range+h6b-1) * int_mb(k_range+p15b-1) * int_mb(k_r
     &ange+h13b-1) * int_mb(k_range+p4b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_8_7_3',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p8b = noab+1,noab+nvab
      DO h10b = 1,noab
      IF (int_mb(k_spin+p15b-1)+int_mb(k_spin+p8b-1) .eq. int_mb(k_spin+
     &h13b-1)+int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p15b-1),ieor(int_mb(k_sym+p8b-1),ieor(int_mb
     &(k_sym+h13b-1),int_mb(k_sym+h10b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p15b,p8b,h13b,h10b,p15b_1,p8b_1,h13b_1,h10b_
     &1)
      CALL TCE_RESTRICTED_4(h6b,h10b,p4b,p8b,h6b_2,h10b_2,p4b_2,p8b_2)
      dim_common = int_mb(k_range+p8b-1) * int_mb(k_range+h10b-1)
      dima_sort = int_mb(k_range+p15b-1) * int_mb(k_range+h13b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h6b-1) * int_mb(k_range+p4b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_8_7_3',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_lambda1_8_7_3',2,MA_ERR)
      IF ((p8b .le. p15b) .and. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h13b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (p15b_1 - noab - 1 + nvab * (p
     &8b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+h10b-1),int_mb(k_range+h13b
     &-1),4,2,3,1,1.0d0)
      END IF
      IF ((p8b .le. p15b) .and. (h13b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h13b_1 - 1 + noab * (p15b_1 - noab - 1 + nvab * (p
     &8b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+h13b-1),int_mb(k_range+h10b
     &-1),3,2,4,1,-1.0d0)
      END IF
      IF ((p15b .lt. p8b) .and. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h13b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (p8b_1 - noab - 1 + nvab * (p1
     &5b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p8b-1),int_mb(k_range+h10b-1),int_mb(k_range+h13b
     &-1),4,1,3,2,-1.0d0)
      END IF
      IF ((p15b .lt. p8b) .and. (h13b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h13b_1 - 1 + noab * (p8b_1 - noab - 1 + nvab * (p1
     &5b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p8b-1),int_mb(k_range+h13b-1),int_mb(k_range+h10b
     &-1),3,1,4,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_lambda1_8_7_3',3,
     &MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_8_7_3',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdtq_lambda1_8_7_3',5,MA_ERR)
      IF ((h10b .lt. h6b) .and. (p8b .lt. p4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p4b_2
     & - 1 + (noab+nvab) * (p8b_2 - 1 + (noab+nvab) * (h6b_2 - 1 + (noab
     &+nvab) * (h10b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+h6b-1),int_mb(k_range+p8b-1),int_mb(k_range+p4b-1
     &),4,2,1,3,1.0d0)
      END IF
      IF ((h10b .lt. h6b) .and. (p4b .le. p8b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p8b_2
     & - 1 + (noab+nvab) * (p4b_2 - 1 + (noab+nvab) * (h6b_2 - 1 + (noab
     &+nvab) * (h10b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+h6b-1),int_mb(k_range+p4b-1),int_mb(k_range+p8b-1
     &),3,2,1,4,-1.0d0)
      END IF
      IF ((h6b .le. h10b) .and. (p8b .lt. p4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p4b_2
     & - 1 + (noab+nvab) * (p8b_2 - 1 + (noab+nvab) * (h10b_2 - 1 + (noa
     &b+nvab) * (h6b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h6b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+p8b-1),int_mb(k_range+p4b-1
     &),4,1,2,3,-1.0d0)
      END IF
      IF ((h6b .le. h10b) .and. (p4b .le. p8b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p8b_2
     & - 1 + (noab+nvab) * (p4b_2 - 1 + (noab+nvab) * (h10b_2 - 1 + (noa
     &b+nvab) * (h6b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h6b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+p4b-1),int_mb(k_range+p8b-1
     &),3,1,2,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdtq_lambda1_8_7_3',6,
     &MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdtq_lambda1_8_7_
     &3',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_lambda1_8_7_
     &3',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_lambda1_8_7_3',9,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p4b-1)
     &,int_mb(k_range+h6b-1),int_mb(k_range+h13b-1),int_mb(k_range+p15b-
     &1),2,4,3,1,-1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p4b -
     & noab - 1 + nvab * (h13b - 1 + noab * (p15b - noab - 1 + nvab * (h
     &6b - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_lambda1_8_7_3',10
     &,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdtq_lambda1_8_7_
     &3',11,MA_ERR)
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
