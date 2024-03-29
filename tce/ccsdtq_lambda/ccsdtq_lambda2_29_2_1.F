      SUBROUTINE ccsdtq_lambda2_29_2_1(d_a,k_a_offset,d_b,k_b_offset,d_c
     &,k_c_offset)
C     $Id: ccsdtq_lambda2_29_2_1.F,v 1.3 2005-12-16 22:42:36 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h7 h8 p14 p1 p2 p5 )_yt + = -1 * Sum ( h12 h11 p9 ) * t ( p9 p14 h11 h12 )_t * i3 ( h7 h8 h11 h12 p1 p2 p5 p9 )_y
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
      INTEGER p14b
      INTEGER h7b
      INTEGER h8b
      INTEGER p1b
      INTEGER p2b
      INTEGER p5b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p9b
      INTEGER h11b
      INTEGER h12b
      INTEGER p14b_1
      INTEGER p9b_1
      INTEGER h11b_1
      INTEGER h12b_1
      INTEGER h7b_2
      INTEGER h8b_2
      INTEGER h11b_2
      INTEGER h12b_2
      INTEGER p1b_2
      INTEGER p2b_2
      INTEGER p5b_2
      INTEGER p9b_2
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
      DO p14b = noab+1,noab+nvab
      DO h7b = 1,noab
      DO h8b = h7b,noab
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      DO p5b = noab+1,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1
     &)+int_mb(k_spin+p14b-1)+int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+
     &int_mb(k_spin+p5b-1).ne.12)) THEN
      IF (int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)+int_mb(k_spin+p14b-1
     &) .eq. int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+int_mb(k_spin+p5b
     &-1)) THEN
      IF (ieor(int_mb(k_sym+h7b-1),ieor(int_mb(k_sym+h8b-1),ieor(int_mb(
     &k_sym+p14b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb(k_sym+p2b-1),in
     &t_mb(k_sym+p5b-1)))))) .eq. ieor(irrep_y,irrep_t)) THEN
      dimc = int_mb(k_range+h7b-1) * int_mb(k_range+h8b-1) * int_mb(k_ra
     &nge+p14b-1) * int_mb(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_
     &mb(k_range+p5b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdtq_lambda2_29_2_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p9b = noab+1,noab+nvab
      DO h11b = 1,noab
      DO h12b = h11b,noab
      IF (int_mb(k_spin+p14b-1)+int_mb(k_spin+p9b-1) .eq. int_mb(k_spin+
     &h11b-1)+int_mb(k_spin+h12b-1)) THEN
      IF (ieor(int_mb(k_sym+p14b-1),ieor(int_mb(k_sym+p9b-1),ieor(int_mb
     &(k_sym+h11b-1),int_mb(k_sym+h12b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p14b,p9b,h11b,h12b,p14b_1,p9b_1,h11b_1,h12b_
     &1)
      CALL TCE_RESTRICTED_8(h7b,h8b,h11b,h12b,p1b,p2b,p5b,p9b,h7b_2,h8b_
     &2,h11b_2,h12b_2,p1b_2,p2b_2,p5b_2,p9b_2)
      dim_common = int_mb(k_range+p9b-1) * int_mb(k_range+h11b-1) * int_
     &mb(k_range+h12b-1)
      dima_sort = int_mb(k_range+p14b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h7b-1) * int_mb(k_range+h8b-1) * int_mb
     &(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_mb(k_range+p5b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_lambda2_29_2_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_lambda2_29_2_1',2,MA_ERR)
      IF ((p9b .le. p14b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h11b_1 - 1 + noab * (p14b_1 - noab - 1 + nvab * (p
     &9b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p9b-1)
     &,int_mb(k_range+p14b-1),int_mb(k_range+h11b-1),int_mb(k_range+h12b
     &-1),2,4,3,1,1.0d0)
      END IF
      IF ((p14b .lt. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h11b_1 - 1 + noab * (p9b_1 - noab - 1 + nvab * (p1
     &4b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p14b-1
     &),int_mb(k_range+p9b-1),int_mb(k_range+h11b-1),int_mb(k_range+h12b
     &-1),1,4,3,2,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_lambda2_29_2_1',3
     &,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdtq_lambda2_29_2_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdtq_lambda2_29_2_1',5,MA_ERR)
      IF ((h12b .lt. h7b) .and. (p9b .lt. p5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h7b_2 - 1
     & + noab * (h12b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h7b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,4,3,2,1,7,-1.0d0)
      END IF
      IF ((h12b .lt. h7b) .and. (p5b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h7b_2 - 1
     & + noab * (h12b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h7b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,4,3,2,1,8,1.0d0)
      END IF
      IF ((h11b .lt. h7b) .and. (h7b .le. h12b) .and. (h12b .lt. h8b) .a
     &nd. (p9b .lt. p5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h12b_2 - 
     &1 + noab * (h7b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h7b-1),int_mb(k_range+h12b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,4,2,3,1,7,1.0d0)
      END IF
      IF ((h11b .lt. h7b) .and. (h7b .le. h12b) .and. (h12b .lt. h8b) .a
     &nd. (p5b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h12b_2 - 
     &1 + noab * (h7b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h7b-1),int_mb(k_range+h12b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,4,2,3,1,8,-1.0d0)
      END IF
      IF ((h11b .lt. h7b) .and. (h8b .le. h12b) .and. (p9b .lt. p5b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h8b_2 - 
     &1 + noab * (h7b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h7b-1),int_mb(k_range+h8b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,3,2,4,1,7,-1.0d0)
      END IF
      IF ((h11b .lt. h7b) .and. (h8b .le. h12b) .and. (p5b .le. p9b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h8b_2 - 
     &1 + noab * (h7b_2 - 1 + noab * (h11b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h7b-1),int_mb(k_range+h8b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,3,2,4,1,8,1.0d0)
      END IF
      IF ((h7b .le. h11b) .and. (h12b .lt. h8b) .and. (p9b .lt. p5b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h12b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h12b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,4,1,3,2,7,-1.0d0)
      END IF
      IF ((h7b .le. h11b) .and. (h12b .lt. h8b) .and. (p5b .le. p9b)) TH
     &EN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h8b_2 - 1 + noab * (h12b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h12b-1),int_mb(k_range+h8b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,4,1,3,2,8,1.0d0)
      END IF
      IF ((h7b .le. h11b) .and. (h11b .lt. h8b) .and. (h8b .le. h12b) .a
     &nd. (p9b .lt. p5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h8b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h8b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,3,1,4,2,7,1.0d0)
      END IF
      IF ((h7b .le. h11b) .and. (h11b .lt. h8b) .and. (h8b .le. h12b) .a
     &nd. (p5b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h8b_2 - 
     &1 + noab * (h11b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h8b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,3,1,4,2,8,-1.0d0)
      END IF
      IF ((h8b .le. h11b) .and. (p9b .lt. p5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p9b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h8b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h8b-1),int_mb(k_range+h11b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p9b-
     &1),int_mb(k_range+p5b-1),8,6,5,2,1,4,3,7,-1.0d0)
      END IF
      IF ((h8b .le. h11b) .and. (p5b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p2b_2 - noab - 1 
     &+ nvab * (p1b_2 - noab - 1 + nvab * (h12b_2 - 1 + noab * (h11b_2 -
     & 1 + noab * (h8b_2 - 1 + noab * (h7b_2 - 1)))))))))
      CALL TCE_SORT_8(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h8b-1),int_mb(k_range+h11b-1),int_mb(k_range+h12b-
     &1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p5b-
     &1),int_mb(k_range+p9b-1),7,6,5,2,1,4,3,8,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdtq_lambda2_29_2_1',6
     &,MA_ERR)
      nsubh(1) = 1
      nsubh(2) = 1
      isubh = 1
      IF (h11b .eq. h12b) THEN
      nsubh(isubh) = nsubh(isubh) + 1
      ELSE
      isubh = isubh + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsubh(1))/FACTORIAL(nsubh(2)),dbl_mb(k_a_sort),dim_common,dbl_mb(k
     &_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdtq_lambda2_29_2
     &_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_lambda2_29_2
     &_1',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_lambda2_29_2_1',9,MA_ERR)
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p1b-1),int_mb(k_range+h8b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+p14b-1),5,4,6,3,2,1,-1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p5b -
     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (p1b - noab - 1 + nvab
     & * (p14b - noab - 1 + nvab * (h8b - 1 + noab * (h7b - 1)))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_lambda2_29_2_1',1
     &0,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdtq_lambda2_29_2
     &_1',11,MA_ERR)
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
