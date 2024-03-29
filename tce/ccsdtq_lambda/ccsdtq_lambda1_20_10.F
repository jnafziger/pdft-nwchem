      SUBROUTINE ccsdtq_lambda1_20_10(d_a,k_a_offset,d_b,k_b_offset,d_c,
     &k_c_offset)
C     $Id: ccsdtq_lambda1_20_10.F,v 1.3 2005-12-16 22:42:24 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p15 p17 p18 h13 h14 h16 )_vt + = 1/6 * Sum ( h10 p5 p6 ) * t ( p5 p6 p15 p17 h10 h13 h14 h16 )_t * v ( h10 p18 p5 p6 )_v
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
      INTEGER p17b
      INTEGER p18b
      INTEGER h13b
      INTEGER h14b
      INTEGER h16b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p5b
      INTEGER p6b
      INTEGER h10b
      INTEGER p15b_1
      INTEGER p17b_1
      INTEGER p5b_1
      INTEGER p6b_1
      INTEGER h13b_1
      INTEGER h14b_1
      INTEGER h16b_1
      INTEGER h10b_1
      INTEGER p18b_2
      INTEGER h10b_2
      INTEGER p5b_2
      INTEGER p6b_2
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
      INTEGER nsuperp(2)
      INTEGER isuperp
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p15b = noab+1,noab+nvab
      DO p17b = p15b,noab+nvab
      DO p18b = noab+1,noab+nvab
      DO h13b = 1,noab
      DO h14b = h13b,noab
      DO h16b = h14b,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p15b-1)+int_mb(k_spin+p17b
     &-1)+int_mb(k_spin+p18b-1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+h14b
     &-1)+int_mb(k_spin+h16b-1).ne.12)) THEN
      IF (int_mb(k_spin+p15b-1)+int_mb(k_spin+p17b-1)+int_mb(k_spin+p18b
     &-1) .eq. int_mb(k_spin+h13b-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin
     &+h16b-1)) THEN
      IF (ieor(int_mb(k_sym+p15b-1),ieor(int_mb(k_sym+p17b-1),ieor(int_m
     &b(k_sym+p18b-1),ieor(int_mb(k_sym+h13b-1),ieor(int_mb(k_sym+h14b-1
     &),int_mb(k_sym+h16b-1)))))) .eq. ieor(irrep_v,irrep_t)) THEN
      dimc = int_mb(k_range+p15b-1) * int_mb(k_range+p17b-1) * int_mb(k_
     &range+p18b-1) * int_mb(k_range+h13b-1) * int_mb(k_range+h14b-1) * 
     &int_mb(k_range+h16b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_20_10',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p5b = noab+1,noab+nvab
      DO p6b = p5b,noab+nvab
      DO h10b = 1,noab
      IF (int_mb(k_spin+p15b-1)+int_mb(k_spin+p17b-1)+int_mb(k_spin+p5b-
     &1)+int_mb(k_spin+p6b-1) .eq. int_mb(k_spin+h13b-1)+int_mb(k_spin+h
     &14b-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p15b-1),ieor(int_mb(k_sym+p17b-1),ieor(int_m
     &b(k_sym+p5b-1),ieor(int_mb(k_sym+p6b-1),ieor(int_mb(k_sym+h13b-1),
     &ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+h16b-1),int_mb(k_sym+h
     &10b-1)))))))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_8(p15b,p17b,p5b,p6b,h13b,h14b,h16b,h10b,p15b_1
     &,p17b_1,p5b_1,p6b_1,h13b_1,h14b_1,h16b_1,h10b_1)
      CALL TCE_RESTRICTED_4(p18b,h10b,p5b,p6b,p18b_2,h10b_2,p5b_2,p6b_2)
      dim_common = int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_m
     &b(k_range+h10b-1)
      dima_sort = int_mb(k_range+p15b-1) * int_mb(k_range+p17b-1) * int_
     &mb(k_range+h13b-1) * int_mb(k_range+h14b-1) * int_mb(k_range+h16b-
     &1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p18b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_20_10',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_lambda1_20_10',2,MA_ERR)
      IF ((p6b .le. p15b) .and. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1 + nvab 
     &* (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p15b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,4,3,5,2,1,1.0d0)
      END IF
      IF ((p6b .le. p15b) .and. (h13b .lt. h10b) .and. (h10b .le. h14b))
     & THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1 + nvab 
     &* (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p15b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,4,3,6,2,1,-1.0d0)
      END IF
      IF ((p6b .le. p15b) .and. (h14b .lt. h10b) .and. (h10b .le. h16b))
     & THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1 + nvab 
     &* (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p15b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,4,3,7,2,1,1.0d0)
      END IF
      IF ((p6b .le. p15b) .and. (h16b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1 + nvab 
     &* (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p15b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,4,3,8,2,1,-1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p15b .lt. p6b) .and. (p6b .le. p17b) .a
     &nd. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,4,2,5,3,1,-1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p15b .lt. p6b) .and. (p6b .le. p17b) .a
     &nd. (h13b .lt. h10b) .and. (h10b .le. h14b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,4,2,6,3,1,1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p15b .lt. p6b) .and. (p6b .le. p17b) .a
     &nd. (h14b .lt. h10b) .and. (h10b .le. h16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,4,2,7,3,1,-1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p15b .lt. p6b) .and. (p6b .le. p17b) .a
     &nd. (h16b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,4,2,8,3,1,1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p17b .lt. p6b) .and. (h10b .le. h13b)) 
     &THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,3,2,5,4,1,1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p17b .lt. p6b) .and. (h13b .lt. h10b) .
     &and. (h10b .le. h14b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,3,2,6,4,1,-1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p17b .lt. p6b) .and. (h14b .lt. h10b) .
     &and. (h10b .le. h16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,3,2,7,4,1,1.0d0)
      END IF
      IF ((p5b .le. p15b) .and. (p17b .lt. p6b) .and. (h16b .lt. h10b)) 
     &THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p15b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,3,2,8,4,1,-1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p6b .le. p17b) .and. (h10b .le. h13b)) 
     &THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,4,1,5,3,2,1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p6b .le. p17b) .and. (h13b .lt. h10b) .
     &and. (h10b .le. h14b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,4,1,6,3,2,-1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p6b .le. p17b) .and. (h14b .lt. h10b) .
     &and. (h10b .le. h16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,4,1,7,3,2,1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p6b .le. p17b) .and. (h16b .lt. h10b)) 
     &THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p17b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p17b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,4,1,8,3,2,-1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p5b .le. p17b) .and. (p17b .lt. p6b) .a
     &nd. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,3,1,5,4,2,-1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p5b .le. p17b) .and. (p17b .lt. p6b) .a
     &nd. (h13b .lt. h10b) .and. (h10b .le. h14b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,3,1,6,4,2,1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p5b .le. p17b) .and. (p17b .lt. p6b) .a
     &nd. (h14b .lt. h10b) .and. (h10b .le. h16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,3,1,7,4,2,-1.0d0)
      END IF
      IF ((p15b .lt. p5b) .and. (p5b .le. p17b) .and. (p17b .lt. p6b) .a
     &nd. (h16b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab *
     & (p5b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p17b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,3,1,8,4,2,1.0d0)
      END IF
      IF ((p17b .lt. p5b) .and. (h10b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 - 1 + noab * (h10b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 + nvab * 
     &(p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p17b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h10b-1),int_mb(k_range+h13b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,6,2,1,5,4,3,1.0d0)
      END IF
      IF ((p17b .lt. p5b) .and. (h13b .lt. h10b) .and. (h10b .le. h14b))
     & THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (h10b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 + nvab * 
     &(p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p17b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1
     &4b-1),int_mb(k_range+h16b-1),8,7,5,2,1,6,4,3,-1.0d0)
      END IF
      IF ((p17b .lt. p5b) .and. (h14b .lt. h10b) .and. (h10b .le. h16b))
     & THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h16b_
     &1 - 1 + noab * (h10b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 + nvab * 
     &(p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p17b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &0b-1),int_mb(k_range+h16b-1),8,6,5,2,1,7,4,3,1.0d0)
      END IF
      IF ((p17b .lt. p5b) .and. (h16b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (h13b_1 -
     & 1 + noab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 + nvab * 
     &(p17b_1 - noab - 1 + nvab * (p15b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p17b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-1),int_mb(k_range+h1
     &6b-1),int_mb(k_range+h10b-1),7,6,5,2,1,8,4,3,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_lambda1_20_10',3,
     &MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdtq_lambda1_20_10',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdtq_lambda1_20_10',5,MA_ERR)
      IF ((h10b .le. p18b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - 1 + (noab+nvab) * (p5b_2 - 1 + (noab+nvab) * (p18b_2 - 1 + (noa
     &b+nvab) * (h10b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),2,1,4,3,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdtq_lambda1_20_10',6,
     &MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      isuperp = 1
      IF (p5b .eq. p6b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdtq_lambda1_20_1
     &0',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_lambda1_20_1
     &0',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_lambda1_20_10',9,MA_ERR)
      IF ((p17b .le. p18b)) THEN
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p18b-1
     &),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+h13
     &b-1),int_mb(k_range+p17b-1),int_mb(k_range+p15b-1),6,5,1,4,3,2,1.0
     &d0/18.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h16b 
     &- 1 + noab * (h14b - 1 + noab * (h13b - 1 + noab * (p18b - noab - 
     &1 + nvab * (p17b - noab - 1 + nvab * (p15b - noab - 1)))))))
      END IF
      IF ((p18b .le. p15b)) THEN
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p18b-1
     &),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+h13
     &b-1),int_mb(k_range+p17b-1),int_mb(k_range+p15b-1),1,6,5,4,3,2,1.0
     &d0/18.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h16b 
     &- 1 + noab * (h14b - 1 + noab * (h13b - 1 + noab * (p17b - noab - 
     &1 + nvab * (p15b - noab - 1 + nvab * (p18b - noab - 1)))))))
      END IF
      IF ((p15b .le. p18b) .and. (p18b .le. p17b)) THEN
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p18b-1
     &),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+h13
     &b-1),int_mb(k_range+p17b-1),int_mb(k_range+p15b-1),6,1,5,4,3,2,-1.
     &0d0/18.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h16b 
     &- 1 + noab * (h14b - 1 + noab * (h13b - 1 + noab * (p17b - noab - 
     &1 + nvab * (p18b - noab - 1 + nvab * (p15b - noab - 1)))))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_lambda1_20_10',10
     &,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdtq_lambda1_20_1
     &0',11,MA_ERR)
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
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
