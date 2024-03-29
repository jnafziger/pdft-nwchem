      SUBROUTINE eomccsdtq_y2_29_2_1_2(d_a,k_a_offset,d_c,k_c_offset)
C     $Id: eomccsdtq_y2_29_2_1_2.F,v 1.2 2005-12-19 19:04:16 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i3 ( h3 h4 h7 h11 p1 p5 p6 p9 )_y + = 1 * y ( h3 h4 h7 h11 p1 p5 p6 p9 )_y
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
      INTEGER h3b
      INTEGER h4b
      INTEGER h7b
      INTEGER h11b
      INTEGER p1b
      INTEGER p5b
      INTEGER p6b
      INTEGER p9b
      INTEGER dimc
      INTEGER h3b_1
      INTEGER h4b_1
      INTEGER h7b_1
      INTEGER h11b_1
      INTEGER p1b_1
      INTEGER p5b_1
      INTEGER p6b_1
      INTEGER p9b_1
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
      DO h3b = 1,noab
      DO h4b = h3b,noab
      DO h7b = 1,noab
      DO h11b = h7b,noab
      DO p1b = noab+1,noab+nvab
      DO p5b = noab+1,noab+nvab
      DO p6b = p5b,noab+nvab
      DO p9b = p6b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1
     &)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h11b-1)+int_mb(k_spin+p1b-1)+
     &int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1)+int_mb(k_spin+p9b-1).ne.
     &16)) THEN
      IF (int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1)+int_mb(k_spin+h7b-1)
     &+int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+p1b-1)+int_mb(k_spin+p5b
     &-1)+int_mb(k_spin+p6b-1)+int_mb(k_spin+p9b-1)) THEN
      IF (ieor(int_mb(k_sym+h3b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+h7b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+p1b-1),ie
     &or(int_mb(k_sym+p5b-1),ieor(int_mb(k_sym+p6b-1),int_mb(k_sym+p9b-1
     &)))))))) .eq. irrep_y) THEN
      dimc = int_mb(k_range+h3b-1) * int_mb(k_range+h4b-1) * int_mb(k_ra
     &nge+h7b-1) * int_mb(k_range+h11b-1) * int_mb(k_range+p1b-1) * int_
     &mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_mb(k_range+p9b-1)
      CALL TCE_RESTRICTED_8(h3b,h4b,h7b,h11b,p1b,p5b,p6b,p9b,h3b_1,h4b_1
     &,h7b_1,h11b_1,p1b_1,p5b_1,p6b_1,p9b_1)
      dim_common = 1
      dima_sort = int_mb(k_range+h3b-1) * int_mb(k_range+h4b-1) * int_mb
     &(k_range+h7b-1) * int_mb(k_range+h11b-1) * int_mb(k_range+p1b-1) *
     & int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_mb(k_range+p9
     &b-1)
      dima = dim_common * dima_sort
      IF (dima .gt. 0) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y2_29_2_1_2',0,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y2_29_2_1_2',1,MA_ERR)
      IF ((h11b .lt. h3b) .and. (p9b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 - 1
     & + noab * (h11b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,2,1,4,3,-1.0d0)
      END IF
      IF ((h11b .lt. h3b) .and. (p6b .lt. p1b) .and. (p1b .le. p9b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 - 1
     & + noab * (h11b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,2,1,4,3,1.0d0)
      END IF
      IF ((h11b .lt. h3b) .and. (p5b .lt. p1b) .and. (p1b .le. p6b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 - 1
     & + noab * (h11b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,2,1,4,3,-1.0d0)
      END IF
      IF ((h11b .lt. h3b) .and. (p1b .le. p5b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 - 1
     & + noab * (h11b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,2,1,4,3,1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h3b .le. h11b) .and. (h11b .lt. h4b) .an
     &d. (p9b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,3,1,4,2,1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h3b .le. h11b) .and. (h11b .lt. h4b) .an
     &d. (p6b .lt. p1b) .and. (p1b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,3,1,4,2,-1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h3b .le. h11b) .and. (h11b .lt. h4b) .an
     &d. (p5b .lt. p1b) .and. (p1b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,3,1,4,2,1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h3b .le. h11b) .and. (h11b .lt. h4b) .an
     &d. (p1b .le. p5b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,3,1,4,2,-1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h4b .le. h11b) .and. (p9b .lt. p1b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,4,1,3,2,-1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h4b .le. h11b) .and. (p6b .lt. p1b) .and
     &. (p1b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,4,1,3,2,1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h4b .le. h11b) .and. (p5b .lt. p1b) .and
     &. (p1b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,4,1,3,2,-1.0d0)
      END IF
      IF ((h7b .lt. h3b) .and. (h4b .le. h11b) .and. (p1b .le. p5b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h3b_1 - 1 + noab * (h7b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,4,1,3,2,1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h11b .lt. h4b) .and. (p9b .lt. p1b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,3,2,4,1,-1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h11b .lt. h4b) .and. (p6b .lt. p1b) .and
     &. (p1b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,3,2,4,1,1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h11b .lt. h4b) .and. (p5b .lt. p1b) .and
     &. (p1b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,3,2,4,1,-1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h11b .lt. h4b) .and. (p1b .le. p5b)) THE
     &N
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h11b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,3,2,4,1,1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h7b .lt. h4b) .and. (h4b .le. h11b) .and
     &. (p9b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,4,2,3,1,1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h7b .lt. h4b) .and. (h4b .le. h11b) .and
     &. (p6b .lt. p1b) .and. (p1b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,4,2,3,1,-1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h7b .lt. h4b) .and. (h4b .le. h11b) .and
     &. (p5b .lt. p1b) .and. (p1b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,4,2,3,1,1.0d0)
      END IF
      IF ((h3b .le. h7b) .and. (h7b .lt. h4b) .and. (h4b .le. h11b) .and
     &. (p1b .le. p5b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h4b_1 - 
     &1 + noab * (h7b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,4,2,3,1,-1.0d0)
      END IF
      IF ((h4b .le. h7b) .and. (p9b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p1b_1
     & - noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h7b_1 - 
     &1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h7b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p9b-1
     &),int_mb(k_range+p1b-1),7,6,5,8,4,3,2,1,-1.0d0)
      END IF
      IF ((h4b .le. h7b) .and. (p6b .lt. p1b) .and. (p1b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p6b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h7b_1 - 
     &1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h7b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p9b-1),8,6,5,7,4,3,2,1,1.0d0)
      END IF
      IF ((h4b .le. h7b) .and. (p5b .lt. p1b) .and. (p1b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p1b_1 - noab - 1 
     &+ nvab * (p5b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h7b_1 - 
     &1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h7b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,5,6,4,3,2,1,-1.0d0)
      END IF
      IF ((h4b .le. h7b) .and. (p1b .le. p5b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p9b_1
     & - noab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p5b_1 - noab - 1 
     &+ nvab * (p1b_1 - noab - 1 + nvab * (h11b_1 - 1 + noab * (h7b_1 - 
     &1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h7b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p9b-1),8,7,6,5,4,3,2,1,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y2_29_2_1_2',2
     &,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y2_29_2_1_2',3,MA_ERR)
      CALL TCE_SORT_8(dbl_mb(k_a_sort),dbl_mb(k_c),int_mb(k_range+p9b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h7b-1),int_mb(k_range+h4b-1
     &),int_mb(k_range+h3b-1),8,7,6,5,4,3,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p9b -
     & noab - 1 + nvab * (p6b - noab - 1 + nvab * (p5b - noab - 1 + nvab
     & * (p1b - noab - 1 + nvab * (h11b - 1 + noab * (h7b - 1 + noab * (
     &h4b - 1 + noab * (h3b - 1)))))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y2_29_2_1_2',4
     &,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y2_29_2_1
     &_2',5,MA_ERR)
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
      END DO
      END DO
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
