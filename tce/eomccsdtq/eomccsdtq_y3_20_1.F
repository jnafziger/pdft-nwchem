      SUBROUTINE eomccsdtq_y3_20_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c
     &_offset)
C     $Id: eomccsdtq_y3_20_1.F,v 1.2 2005-12-19 19:04:20 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h4 h11 p8 p1 p2 p3 )_yt + = -1 * Sum ( h10 h9 p7 ) * t ( p7 p8 h9 h10 )_t * y ( h4 h9 h10 h11 p1 p2 p3 p7 )_y
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
      INTEGER h4b
      INTEGER p8b
      INTEGER h11b
      INTEGER p1b
      INTEGER p2b
      INTEGER p3b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p7b
      INTEGER h9b
      INTEGER h10b
      INTEGER p8b_1
      INTEGER p7b_1
      INTEGER h9b_1
      INTEGER h10b_1
      INTEGER h4b_2
      INTEGER h11b_2
      INTEGER h9b_2
      INTEGER h10b_2
      INTEGER p1b_2
      INTEGER p2b_2
      INTEGER p3b_2
      INTEGER p7b_2
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
      INTEGER nsubh(2)
      INTEGER isubh
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h4b = 1,noab
      DO p8b = noab+1,noab+nvab
      DO h11b = 1,noab
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      DO p3b = p2b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h4b-1)+int_mb(k_spin+h11b-
     &1)+int_mb(k_spin+p8b-1)+int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+
     &int_mb(k_spin+p3b-1).ne.12)) THEN
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+h11b-1)+int_mb(k_spin+p8b-1
     &) .eq. int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+int_mb(k_spin+p3b
     &-1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb
     &(k_sym+p8b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb(k_sym+p2b-1),in
     &t_mb(k_sym+p3b-1)))))) .eq. ieor(irrep_y,irrep_t)) THEN
      dimc = int_mb(k_range+h4b-1) * int_mb(k_range+h11b-1) * int_mb(k_r
     &ange+p8b-1) * int_mb(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_
     &mb(k_range+p3b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsdtq_y3_20_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p7b = noab+1,noab+nvab
      DO h9b = 1,noab
      DO h10b = h9b,noab
      IF (int_mb(k_spin+p8b-1)+int_mb(k_spin+p7b-1) .eq. int_mb(k_spin+h
     &9b-1)+int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p8b-1),ieor(int_mb(k_sym+p7b-1),ieor(int_mb(
     &k_sym+h9b-1),int_mb(k_sym+h10b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p8b,p7b,h9b,h10b,p8b_1,p7b_1,h9b_1,h10b_1)
      CALL TCE_RESTRICTED_8(h4b,h11b,h9b,h10b,p1b,p2b,p3b,p7b,h4b_2,h11b
     &_2,h9b_2,h10b_2,p1b_2,p2b_2,p3b_2,p7b_2)
      dim_common = int_mb(k_range+p7b-1) * int_mb(k_range+h9b-1) * int_m
     &b(k_range+h10b-1)
      dima_sort = int_mb(k_range+p8b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h4b-1) * int_mb(k_range+h11b-1) * int_m
     &b(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_mb(k_range+p3b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y3_20_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y3_20_1',2,MA_ERR)
      IF ((p7b .le. p8b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h9b_1 - 1 + noab * (p8b_1 - noab - 1 + nvab * (p7b
     &_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p7b-1)
     &,int_mb(k_range+p8b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1
     &),2,4,3,1,1.0d0)
      END IF
      IF ((p8b .lt. p7b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h9b_1 - 1 + noab * (p7b_1 - noab - 1 + nvab * (p8b
     &_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p7b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1
     &),1,4,3,2,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y3_20_1',3,MA_
     &ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsdtq_y3_20_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsdtq_y3_20_1',5,MA_ERR)
      IF ((h10b .le. h11b) .and. (h11b .lt. h4b) .and. (p7b .lt. p1b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h11b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,3,4,2,1,5,1.0d0)
      END IF
      IF ((h10b .le. h11b) .and. (h11b .lt. h4b) .and. (p1b .le. p7b) .a
     &nd. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h11b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,3,4,2,1,6,-1.0d0)
      END IF
      IF ((h10b .le. h11b) .and. (h11b .lt. h4b) .and. (p2b .le. p7b) .a
     &nd. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h11b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,3,4,2,1,7,1.0d0)
      END IF
      IF ((h10b .le. h11b) .and. (h11b .lt. h4b) .and. (p3b .le. p7b)) T
     &HEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h11b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h11b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,3,4,2,1,8,-1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h10b) .and. (h10b .lt. h4b) .
     &and. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,2,4,3,1,5,-1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h10b) .and. (h10b .lt. h4b) .
     &and. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,2,4,3,1,6,1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h10b) .and. (h10b .lt. h4b) .
     &and. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,2,4,3,1,7,-1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h10b) .and. (h10b .lt. h4b) .
     &and. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,2,4,3,1,8,1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h4b) .and. (h4b .le. h10b) .a
     &nd. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,2,3,4,1,5,1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h4b) .and. (h4b .le. h10b) .a
     &nd. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,2,3,4,1,6,-1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h4b) .and. (h4b .le. h10b) .a
     &nd. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,2,3,4,1,7,1.0d0)
      END IF
      IF ((h9b .le. h11b) .and. (h11b .lt. h4b) .and. (h4b .le. h10b) .a
     &nd. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,2,3,4,1,8,-1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h10b .lt. h4b) .and. (p7b .lt. p1b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,1,4,3,2,5,1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h10b .lt. h4b) .and. (p1b .le. p7b) .an
     &d. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,1,4,3,2,6,-1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h10b .lt. h4b) .and. (p2b .le. p7b) .an
     &d. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,1,4,3,2,7,1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h10b .lt. h4b) .and. (p3b .le. p7b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab * (h10b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h4b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,1,4,3,2,8,-1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h9b .lt. h4b) .and. (h4b .le. h10b) .an
     &d. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,1,3,4,2,5,-1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h9b .lt. h4b) .and. (h4b .le. h10b) .an
     &d. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,1,3,4,2,6,1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h9b .lt. h4b) .and. (h4b .le. h10b) .an
     &d. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,1,3,4,2,7,-1.0d0)
      END IF
      IF ((h11b .lt. h9b) .and. (h9b .lt. h4b) .and. (h4b .le. h10b) .an
     &d. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h9b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h9b-1),int_mb(k_range+h4b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,1,3,4,2,8,1.0d0)
      END IF
      IF ((h11b .lt. h4b) .and. (h4b .le. h9b) .and. (p7b .lt. p1b)) THE
     &N
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h4b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,1,2,4,3,5,1.0d0)
      END IF
      IF ((h11b .lt. h4b) .and. (h4b .le. h9b) .and. (p1b .le. p7b) .and
     &. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h4b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,1,2,4,3,6,-1.0d0)
      END IF
      IF ((h11b .lt. h4b) .and. (h4b .le. h9b) .and. (p2b .le. p7b) .and
     &. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h4b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,1,2,4,3,7,1.0d0)
      END IF
      IF ((h11b .lt. h4b) .and. (h4b .le. h9b) .and. (p3b .le. p7b)) THE
     &N
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h4b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,1,2,4,3,8,-1.0d0)
      END IF
      IF ((h10b .lt. h4b) .and. (h4b .le. h11b) .and. (p7b .lt. p1b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,4,3,2,1,5,-1.0d0)
      END IF
      IF ((h10b .lt. h4b) .and. (h4b .le. h11b) .and. (p1b .le. p7b) .an
     &d. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,4,3,2,1,6,1.0d0)
      END IF
      IF ((h10b .lt. h4b) .and. (h4b .le. h11b) .and. (p2b .le. p7b) .an
     &d. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,4,3,2,1,7,-1.0d0)
      END IF
      IF ((h10b .lt. h4b) .and. (h4b .le. h11b) .and. (p3b .le. p7b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h4b_2 - 
     &1 + noab * (h10b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h10b-1),int_mb(k_range+h4b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,4,3,2,1,8,1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h10b) .and. (h10b .le. h11b) .a
     &nd. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,4,2,3,1,5,1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h10b) .and. (h10b .le. h11b) .a
     &nd. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,4,2,3,1,6,-1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h10b) .and. (h10b .le. h11b) .a
     &nd. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,4,2,3,1,7,1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h10b) .and. (h10b .le. h11b) .a
     &nd. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,4,2,3,1,8,-1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,3,2,4,1,5,-1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,3,2,4,1,6,1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,3,2,4,1,7,-1.0d0)
      END IF
      IF ((h9b .lt. h4b) .and. (h4b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h4b_2 - 1 + noab * (h9b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,3,2,4,1,8,1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h10b .le. h11b) .and. (p7b .lt. p1b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,4,1,3,2,5,-1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h10b .le. h11b) .and. (p1b .le. p7b) .an
     &d. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,4,1,3,2,6,1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h10b .le. h11b) .and. (p2b .le. p7b) .an
     &d. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,4,1,3,2,7,-1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h10b .le. h11b) .and. (p3b .le. p7b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h11b_2 - 1 + noab * (h10b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h11b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,4,1,3,2,8,1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h9b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p7b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,3,1,4,2,5,1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h9b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p1b .le. p7b) .and. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,3,1,4,2,6,-1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h9b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p2b .le. p7b) .and. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,3,1,4,2,7,1.0d0)
      END IF
      IF ((h4b .le. h9b) .and. (h9b .le. h11b) .and. (h11b .lt. h10b) .a
     &nd. (p3b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h9b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h9b-1),int_mb(k_range+h11b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,3,1,4,2,8,-1.0d0)
      END IF
      IF ((h4b .le. h11b) .and. (h11b .lt. h9b) .and. (p7b .lt. p1b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (p7b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p7b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,6,2,1,4,3,5,-1.0d0)
      END IF
      IF ((h4b .le. h11b) .and. (h11b .lt. h9b) .and. (p1b .le. p7b) .an
     &d. (p7b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p7b-1),int_mb(k_range+p2b-
     &1),int_mb(k_range+p3b-1),8,7,5,2,1,4,3,6,1.0d0)
      END IF
      IF ((h4b .le. h11b) .and. (h11b .lt. h9b) .and. (p2b .le. p7b) .an
     &d. (p7b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p7b-
     &1),int_mb(k_range+p3b-1),8,6,5,2,1,4,3,7,-1.0d0)
      END IF
      IF ((h4b .le. h11b) .and. (h11b .lt. h9b) .and. (p3b .le. p7b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p7b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h10b_2 - 1 + noab * (h9b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h4b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h9b-1),int_mb(k_range+h10b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-
     &1),int_mb(k_range+p7b-1),7,6,5,2,1,4,3,8,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsdtq_y3_20_1',6,MA_
     &ERR)
      nsubh(1) = 1
      nsubh(2) = 1
      isubh = 1
      IF (h9b .eq. h10b) THEN
      nsubh(isubh) = nsubh(isubh) + 1
      ELSE
      isubh = isubh + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsubh(1))/FACTORIAL(nsubh(2)),dbl_mb(k_a_sort),dim_common,dbl_mb(k
     &_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsdtq_y3_20_1',
     &7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y3_20_1',
     &8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y3_20_1',9,MA_ERR)
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p1b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+p8b-1),5,4,6,3,2,1,-1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (p1b - noab - 1 + nvab
     & * (p8b - noab - 1 + nvab * (h11b - 1 + noab * (h4b - 1)))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y3_20_1',10,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsdtq_y3_20_1',
     &11,MA_ERR)
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
