      SUBROUTINE eomccsdtq_y2_12(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_o
     &ffset)
C     $Id: eomccsdtq_y2_12.F,v 1.2 2005-12-19 19:04:12 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h3 h4 p1 p2 )_yv + = 1/4 * Sum ( h15 h14 p17 p16 ) * y ( h3 h4 h14 h15 p1 p2 p16 p17 )_y * i1 ( p16 p17 h14 h15 )_v
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
      INTEGER h3b
      INTEGER h4b
      INTEGER p1b
      INTEGER p2b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h14b
      INTEGER h15b
      INTEGER p16b
      INTEGER p17b
      INTEGER h3b_1
      INTEGER h4b_1
      INTEGER h14b_1
      INTEGER h15b_1
      INTEGER p1b_1
      INTEGER p2b_1
      INTEGER p16b_1
      INTEGER p17b_1
      INTEGER p16b_2
      INTEGER p17b_2
      INTEGER h14b_2
      INTEGER h15b_2
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
      INTEGER nsuperh(2)
      INTEGER isuperh
      INTEGER nsubp(2)
      INTEGER isubp
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h3b = 1,noab
      DO h4b = h3b,noab
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1
     &)+int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1).ne.8)) THEN
      IF (int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1) .eq. int_mb(k_spin+p
     &1b-1)+int_mb(k_spin+p2b-1)) THEN
      IF (ieor(int_mb(k_sym+h3b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+p1b-1),int_mb(k_sym+p2b-1)))) .eq. ieor(irrep_y,irrep_v)) TH
     &EN
      dimc = int_mb(k_range+h3b-1) * int_mb(k_range+h4b-1) * int_mb(k_ra
     &nge+p1b-1) * int_mb(k_range+p2b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsdtq_y2_12',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h14b = 1,noab
      DO h15b = h14b,noab
      DO p16b = noab+1,noab+nvab
      DO p17b = p16b,noab+nvab
      IF (int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1)+int_mb(k_spin+h14b-1
     &)+int_mb(k_spin+h15b-1) .eq. int_mb(k_spin+p1b-1)+int_mb(k_spin+p2
     &b-1)+int_mb(k_spin+p16b-1)+int_mb(k_spin+p17b-1)) THEN
      IF (ieor(int_mb(k_sym+h3b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+h14b-1),ieor(int_mb(k_sym+h15b-1),ieor(int_mb(k_sym+p1b-1),i
     &eor(int_mb(k_sym+p2b-1),ieor(int_mb(k_sym+p16b-1),int_mb(k_sym+p17
     &b-1)))))))) .eq. irrep_y) THEN
      CALL TCE_RESTRICTED_8(h3b,h4b,h14b,h15b,p1b,p2b,p16b,p17b,h3b_1,h4
     &b_1,h14b_1,h15b_1,p1b_1,p2b_1,p16b_1,p17b_1)
      CALL TCE_RESTRICTED_4(p16b,p17b,h14b,h15b,p16b_2,p17b_2,h14b_2,h15
     &b_2)
      dim_common = int_mb(k_range+h14b-1) * int_mb(k_range+h15b-1) * int
     &_mb(k_range+p16b-1) * int_mb(k_range+p17b-1)
      dima_sort = int_mb(k_range+h3b-1) * int_mb(k_range+h4b-1) * int_mb
     &(k_range+p1b-1) * int_mb(k_range+p2b-1)
      dima = dim_common * dima_sort
      dimb_sort = 1
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y2_12',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y2_12',2,MA_ERR)
      IF ((h15b .lt. h3b) .and. (p17b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,4,3,6,5,2,1,1.0d0)
      END IF
      IF ((h15b .lt. h3b) .and. (p16b .lt. p1b) .and. (p1b .le. p17b) .a
     &nd. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,4,3,7,5,2,1,-1.0d0)
      END IF
      IF ((h15b .lt. h3b) .and. (p16b .lt. p1b) .and. (p2b .le. p17b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,4,3,8,5,2,1,1.0d0)
      END IF
      IF ((h15b .lt. h3b) .and. (p1b .le. p16b) .and. (p17b .lt. p2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,4,3,7,6,2,1,1.0d0)
      END IF
      IF ((h15b .lt. h3b) .and. (p1b .le. p16b) .and. (p16b .lt. p2b) .a
     &nd. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,4,3,8,6,2,1,-1.0d0)
      END IF
      IF ((h15b .lt. h3b) .and. (p2b .le. p16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h3b_1 -
     & 1 + noab * (h15b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,4,3,8,7,2,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p17b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,4,2,6,5,3,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p16b .lt. p1b) .and. (p1b .le. p17b) .and. (p17b .lt. p2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,4,2,7,5,3,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p16b .lt. p1b) .and. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,4,2,8,5,3,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p1b .le. p16b) .and. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,4,2,7,6,3,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p1b .le. p16b) .and. (p16b .lt. p2b) .and. (p2b .le. p17b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,4,2,8,6,3,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h3b .le. h15b) .and. (h15b .lt. h4b) .a
     &nd. (p2b .le. p16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,4,2,8,7,3,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p17b .lt. p1b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,3,2,6,5,4,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p16b .lt. p1b) .a
     &nd. (p1b .le. p17b) .and. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,3,2,7,5,4,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p16b .lt. p1b) .a
     &nd. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,3,2,8,5,4,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p1b .le. p16b) .a
     &nd. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,3,2,7,6,4,1,1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p1b .le. p16b) .a
     &nd. (p16b .lt. p2b) .and. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,3,2,8,6,4,1,-1.0d0)
      END IF
      IF ((h14b .lt. h3b) .and. (h4b .le. h15b) .and. (p2b .le. p16b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h3b_1 - 1 + noab * (h14b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h14b-1
     &),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,3,2,8,7,4,1,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p17b .lt. p1b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,4,1,6,5,3,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p16b .lt. p1b) .a
     &nd. (p1b .le. p17b) .and. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,4,1,7,5,3,2,-1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p16b .lt. p1b) .a
     &nd. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,4,1,8,5,3,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p1b .le. p16b) .a
     &nd. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,4,1,7,6,3,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p1b .le. p16b) .a
     &nd. (p16b .lt. p2b) .and. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,4,1,8,6,3,2,-1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h15b .lt. h4b) .and. (p2b .le. p16b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab * (h15b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h15b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,4,1,8,7,3,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p17b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,3,1,6,5,4,2,-1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p16b .lt. p1b) .and. (p1b .le. p17b) .and. (p17b .lt. p2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,3,1,7,5,4,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p16b .lt. p1b) .and. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,3,1,8,5,4,2,-1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p1b .le. p16b) .and. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,3,1,7,6,4,2,-1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p1b .le. p16b) .and. (p16b .lt. p2b) .and. (p2b .le. p17b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,3,1,8,6,4,2,1.0d0)
      END IF
      IF ((h3b .le. h14b) .and. (h14b .lt. h4b) .and. (h4b .le. h15b) .a
     &nd. (p2b .le. p16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h4b_1 
     &- 1 + noab * (h14b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h14b-1),int_mb(k_range+h4b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,3,1,8,7,4,2,-1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p17b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (p17b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p17b-1),int_mb(k_range+p1
     &b-1),int_mb(k_range+p2b-1),8,7,2,1,6,5,4,3,1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p16b .lt. p1b) .and. (p1b .le. p17b) .a
     &nd. (p17b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,6,2,1,7,5,4,3,-1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p16b .lt. p1b) .and. (p2b .le. p17b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1
     & + nvab * (p16b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p16b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,6,2,1,8,5,4,3,1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p1b .le. p16b) .and. (p17b .lt. p2b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p17b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p17
     &b-1),int_mb(k_range+p2b-1),8,5,2,1,7,6,4,3,1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p1b .le. p16b) .and. (p16b .lt. p2b) .a
     &nd. (p2b .le. p17b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p16b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p16b-1),int_mb(k_range+p2b
     &-1),int_mb(k_range+p17b-1),7,5,2,1,8,6,4,3,-1.0d0)
      END IF
      IF ((h4b .le. h14b) .and. (p2b .le. p16b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p17b_
     &1 - noab - 1 + nvab * (p16b_1 - noab - 1 + nvab * (p2b_1 - noab - 
     &1 + nvab * (p1b_1 - noab - 1 + nvab * (h15b_1 - 1 + noab * (h14b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (h3b_1 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p16b
     &-1),int_mb(k_range+p17b-1),6,5,2,1,8,7,4,3,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y2_12',3,MA_ER
     &R)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsdtq_y2_12',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsdtq_y2_12',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h15b_
     &2 - 1 + noab * (h14b_2 - 1 + noab * (p17b_2 - noab - 1 + nvab * (p
     &16b_2 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p16b-1
     &),int_mb(k_range+p17b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15
     &b-1),2,1,4,3,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsdtq_y2_12',6,MA_ER
     &R)
      nsuperh(1) = 1
      nsuperh(2) = 1
      isuperh = 1
      IF (h14b .eq. h15b) THEN
      nsuperh(isuperh) = nsuperh(isuperh) + 1
      ELSE
      isuperh = isuperh + 1
      END IF
      nsubp(1) = 1
      nsubp(2) = 1
      isubp = 1
      IF (p16b .eq. p17b) THEN
      nsubp(isubp) = nsubp(isubp) + 1
      ELSE
      isubp = isubp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,4.0d0/FACTORIAL(
     &nsuperh(1))/FACTORIAL(nsuperh(2))/FACTORIAL(nsubp(1))/FACTORIAL(ns
     &ubp(2)),dbl_mb(k_a_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.
     &0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsdtq_y2_12',7,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y2_12',8,
     &MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y2_12',9,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p2b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+h4b-1),int_mb(k_range+h3b-1)
     &,4,3,2,1,1.0d0/4.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p2b -
     & noab - 1 + nvab * (p1b - noab - 1 + nvab * (h4b - 1 + noab * (h3b
     & - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y2_12',10,MA_E
     &RR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsdtq_y2_12',11
     &,MA_ERR)
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
