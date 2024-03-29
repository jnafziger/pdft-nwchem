      SUBROUTINE ccsdtq_t4_8_3(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: ccsdtq_t4_8_3.F,v 1.3 2005-12-16 22:39:03 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h13 p5 p6 p7 h1 h2 h3 h4 )_vt + = 1/12 * P( 4 ) * Sum ( h11 p14 ) * t ( p5 p6 p7 p14 h1 h2 h3 h11 )_t * i2 ( h11 h13 h4 p14 )_v
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
      INTEGER p5b
      INTEGER p6b
      INTEGER p7b
      INTEGER h13b
      INTEGER h1b
      INTEGER h2b
      INTEGER h3b
      INTEGER h4b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p14b
      INTEGER h11b
      INTEGER p5b_1
      INTEGER p6b_1
      INTEGER p7b_1
      INTEGER p14b_1
      INTEGER h1b_1
      INTEGER h2b_1
      INTEGER h3b_1
      INTEGER h11b_1
      INTEGER h13b_2
      INTEGER h11b_2
      INTEGER h4b_2
      INTEGER p14b_2
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
      DO p5b = noab+1,noab+nvab
      DO p6b = p5b,noab+nvab
      DO p7b = p6b,noab+nvab
      DO h13b = 1,noab
      DO h1b = 1,noab
      DO h2b = h1b,noab
      DO h3b = h2b,noab
      DO h4b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1
     &)+int_mb(k_spin+p7b-1)+int_mb(k_spin+h13b-1)+int_mb(k_spin+h1b-1)+
     &int_mb(k_spin+h2b-1)+int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1).ne.
     &16)) THEN
      IF (int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1)+int_mb(k_spin+p7b-1)
     &+int_mb(k_spin+h13b-1) .eq. int_mb(k_spin+h1b-1)+int_mb(k_spin+h2b
     &-1)+int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+p5b-1),ieor(int_mb(k_sym+p6b-1),ieor(int_mb(
     &k_sym+p7b-1),ieor(int_mb(k_sym+h13b-1),ieor(int_mb(k_sym+h1b-1),ie
     &or(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h3b-1),int_mb(k_sym+h4b-1
     &)))))))) .eq. ieor(irrep_v,irrep_t)) THEN
      dimc = int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_mb(k_ra
     &nge+p7b-1) * int_mb(k_range+h13b-1) * int_mb(k_range+h1b-1) * int_
     &mb(k_range+h2b-1) * int_mb(k_range+h3b-1) * int_mb(k_range+h4b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdtq_t4_8_3',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p14b = noab+1,noab+nvab
      DO h11b = 1,noab
      IF (int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1)+int_mb(k_spin+p7b-1)
     &+int_mb(k_spin+p14b-1) .eq. int_mb(k_spin+h1b-1)+int_mb(k_spin+h2b
     &-1)+int_mb(k_spin+h3b-1)+int_mb(k_spin+h11b-1)) THEN
      IF (ieor(int_mb(k_sym+p5b-1),ieor(int_mb(k_sym+p6b-1),ieor(int_mb(
     &k_sym+p7b-1),ieor(int_mb(k_sym+p14b-1),ieor(int_mb(k_sym+h1b-1),ie
     &or(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h3b-1),int_mb(k_sym+h11b-
     &1)))))))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_8(p5b,p6b,p7b,p14b,h1b,h2b,h3b,h11b,p5b_1,p6b_
     &1,p7b_1,p14b_1,h1b_1,h2b_1,h3b_1,h11b_1)
      CALL TCE_RESTRICTED_4(h13b,h11b,h4b,p14b,h13b_2,h11b_2,h4b_2,p14b_
     &2)
      dim_common = int_mb(k_range+p14b-1) * int_mb(k_range+h11b-1)
      dima_sort = int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_mb
     &(k_range+p7b-1) * int_mb(k_range+h1b-1) * int_mb(k_range+h2b-1) * 
     &int_mb(k_range+h3b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h13b-1) * int_mb(k_range+h4b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_t4_8_3',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_t4_8_3',2,MA_ERR)
      IF ((p14b .lt. p5b) .and. (h11b .lt. h1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 + noab * (h11b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5
     &b_1 - noab - 1 + nvab * (p14b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+h1b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,6,4,3,2,5,1,1.0d0)
      END IF
      IF ((p14b .lt. p5b) .and. (h1b .le. h11b) .and. (h11b .lt. h2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h11b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5
     &b_1 - noab - 1 + nvab * (p14b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h11b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,5,4,3,2,6,1,-1.0d0)
      END IF
      IF ((p14b .lt. p5b) .and. (h2b .le. h11b) .and. (h11b .lt. h3b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h11b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5
     &b_1 - noab - 1 + nvab * (p14b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+h3b-1),8,6,5,4,3,2,7,1,1.0d0)
      END IF
      IF ((p14b .lt. p5b) .and. (h3b .le. h11b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h11b_
     &1 - 1 + noab * (h3b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5
     &b_1 - noab - 1 + nvab * (p14b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h3b-1
     &),int_mb(k_range+h11b-1),7,6,5,4,3,2,8,1,-1.0d0)
      END IF
      IF ((p5b .le. p14b) .and. (p14b .lt. p6b) .and. (h11b .lt. h1b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 + noab * (h11b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1
     &4b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p14b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+h1b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,6,4,3,1,5,2,-1.0d0)
      END IF
      IF ((p5b .le. p14b) .and. (p14b .lt. p6b) .and. (h1b .le. h11b) .a
     &nd. (h11b .lt. h2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h11b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1
     &4b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p14b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h11b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,5,4,3,1,6,2,1.0d0)
      END IF
      IF ((p5b .le. p14b) .and. (p14b .lt. p6b) .and. (h2b .le. h11b) .a
     &nd. (h11b .lt. h3b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h11b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1
     &4b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p14b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+h3b-1),8,6,5,4,3,1,7,2,-1.0d0)
      END IF
      IF ((p5b .le. p14b) .and. (p14b .lt. p6b) .and. (h3b .le. h11b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h11b_
     &1 - 1 + noab * (h3b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1
     &4b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p14b-1),int_mb(k_range+p6b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h3b-1
     &),int_mb(k_range+h11b-1),7,6,5,4,3,1,8,2,1.0d0)
      END IF
      IF ((p6b .le. p14b) .and. (p14b .lt. p7b) .and. (h11b .lt. h1b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 + noab * (h11b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p14b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p14b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+h1b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,6,4,2,1,5,3,1.0d0)
      END IF
      IF ((p6b .le. p14b) .and. (p14b .lt. p7b) .and. (h1b .le. h11b) .a
     &nd. (h11b .lt. h2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h11b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p14b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p14b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h11b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,5,4,2,1,6,3,-1.0d0)
      END IF
      IF ((p6b .le. p14b) .and. (p14b .lt. p7b) .and. (h2b .le. h11b) .a
     &nd. (h11b .lt. h3b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h11b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p14b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p14b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+h3b-1),8,6,5,4,2,1,7,3,1.0d0)
      END IF
      IF ((p6b .le. p14b) .and. (p14b .lt. p7b) .and. (h3b .le. h11b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h11b_
     &1 - 1 + noab * (h3b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p7b_1 - noab - 1 + nvab * (p14b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p14b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h3b-1
     &),int_mb(k_range+h11b-1),7,6,5,4,2,1,8,3,-1.0d0)
      END IF
      IF ((p7b .le. p14b) .and. (h11b .lt. h1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 + noab * (h11b_1 - 1 
     &+ noab * (p14b_1 - noab - 1 + nvab * (p7b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p7b-1),int_mb(k_range+p14b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+h1b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,6,3,2,1,5,4,-1.0d0)
      END IF
      IF ((p7b .le. p14b) .and. (h1b .le. h11b) .and. (h11b .lt. h2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h2b_1 - 1 + noab * (h11b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p14b_1 - noab - 1 + nvab * (p7b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p7b-1),int_mb(k_range+p14b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h11b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h3b-1),8,7,5,3,2,1,6,4,1.0d0)
      END IF
      IF ((p7b .le. p14b) .and. (h2b .le. h11b) .and. (h11b .lt. h3b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (h11b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p14b_1 - noab - 1 + nvab * (p7b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p7b-1),int_mb(k_range+p14b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+h3b-1),8,6,5,3,2,1,7,4,-1.0d0)
      END IF
      IF ((p7b .le. p14b) .and. (h3b .le. h11b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h11b_
     &1 - 1 + noab * (h3b_1 - 1 + noab * (h2b_1 - 1 + noab * (h1b_1 - 1 
     &+ noab * (p14b_1 - noab - 1 + nvab * (p7b_1 - noab - 1 + nvab * (p
     &6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p7b-1),int_mb(k_range+p14b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+h3b-1
     &),int_mb(k_range+h11b-1),7,6,5,3,2,1,8,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_t4_8_3',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdtq_t4_8_3',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdtq_t4_8_3',5,MA_ERR)
      IF ((h11b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p14b_
     &2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h13b_2 - 1 + noab * (h1
     &1b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h13b-1),int_mb(k_range+h4b-1),int_mb(k_range+p14b
     &-1),3,2,1,4,1.0d0)
      END IF
      IF ((h13b .lt. h11b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p14b_
     &2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h11b_2 - 1 + noab * (h1
     &3b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h13b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1),int_mb(k_range+p14b
     &-1),3,1,2,4,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdtq_t4_8_3',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdtq_t4_8_3',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_t4_8_3',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_t4_8_3',9,MA_ERR)
      IF ((h3b .le. h4b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h3b-1),int_mb(k_range+h2b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p5b-1),8,7,6,2,5,4,3,1,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h4b -
     & 1 + noab * (h3b - 1 + noab * (h2b - 1 + noab * (h1b - 1 + noab * 
     &(h13b - 1 + noab * (p7b - noab - 1 + nvab * (p6b - noab - 1 + nvab
     & * (p5b - noab - 1)))))))))
      END IF
      IF ((h4b .le. h1b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h3b-1),int_mb(k_range+h2b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p5b-1),8,7,6,2,1,5,4,3,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h3b -
     & 1 + noab * (h2b - 1 + noab * (h1b - 1 + noab * (h4b - 1 + noab * 
     &(h13b - 1 + noab * (p7b - noab - 1 + nvab * (p6b - noab - 1 + nvab
     & * (p5b - noab - 1)))))))))
      END IF
      IF ((h1b .le. h4b) .and. (h4b .le. h2b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h3b-1),int_mb(k_range+h2b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p5b-1),8,7,6,2,5,1,4,3,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h3b -
     & 1 + noab * (h2b - 1 + noab * (h4b - 1 + noab * (h1b - 1 + noab * 
     &(h13b - 1 + noab * (p7b - noab - 1 + nvab * (p6b - noab - 1 + nvab
     & * (p5b - noab - 1)))))))))
      END IF
      IF ((h2b .le. h4b) .and. (h4b .le. h3b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h3b-1),int_mb(k_range+h2b-1
     &),int_mb(k_range+h1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p5b-1),8,7,6,2,5,4,1,3,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h3b -
     & 1 + noab * (h4b - 1 + noab * (h2b - 1 + noab * (h1b - 1 + noab * 
     &(h13b - 1 + noab * (p7b - noab - 1 + nvab * (p6b - noab - 1 + nvab
     & * (p5b - noab - 1)))))))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_t4_8_3',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdtq_t4_8_3',11,M
     &A_ERR)
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
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
