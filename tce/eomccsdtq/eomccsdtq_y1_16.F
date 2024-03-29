      SUBROUTINE eomccsdtq_y1_16(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_o
     &ffset)
C     $Id: eomccsdtq_y1_16.F,v 1.2 2005-12-19 19:04:03 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h2 p1 )_ytv + = 1/4 * Sum ( h12 h9 h11 ) * i1 ( h9 h12 h11 p1 )_yt * v ( h2 h11 h9 h12 )_v
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
      INTEGER h2b
      INTEGER p1b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h9b
      INTEGER h12b
      INTEGER h11b
      INTEGER h9b_1
      INTEGER h12b_1
      INTEGER p1b_1
      INTEGER h11b_1
      INTEGER h2b_2
      INTEGER h11b_2
      INTEGER h9b_2
      INTEGER h12b_2
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
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h2b = 1,noab
      DO p1b = noab+1,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+p1b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+h2b-1) .eq. int_mb(k_spin+p1b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),int_mb(k_sym+p1b-1)) .eq. ieor(irrep_
     &y,ieor(irrep_t,irrep_v))) THEN
      dimc = int_mb(k_range+h2b-1) * int_mb(k_range+p1b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_16',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h9b = 1,noab
      DO h12b = h9b,noab
      DO h11b = 1,noab
      IF (int_mb(k_spin+h9b-1)+int_mb(k_spin+h12b-1) .eq. int_mb(k_spin+
     &p1b-1)+int_mb(k_spin+h11b-1)) THEN
      IF (ieor(int_mb(k_sym+h9b-1),ieor(int_mb(k_sym+h12b-1),ieor(int_mb
     &(k_sym+p1b-1),int_mb(k_sym+h11b-1)))) .eq. ieor(irrep_y,irrep_t)) 
     &THEN
      CALL TCE_RESTRICTED_4(h9b,h12b,p1b,h11b,h9b_1,h12b_1,p1b_1,h11b_1)
      CALL TCE_RESTRICTED_4(h2b,h11b,h9b,h12b,h2b_2,h11b_2,h9b_2,h12b_2)
      dim_common = int_mb(k_range+h9b-1) * int_mb(k_range+h12b-1) * int_
     &mb(k_range+h11b-1)
      dima_sort = int_mb(k_range+p1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h2b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_16',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y1_16',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h11b_
     &1 - 1 + noab * (p1b_1 - noab - 1 + nvab * (h12b_1 - 1 + noab * (h9
     &b_1 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h9b-1)
     &,int_mb(k_range+h12b-1),int_mb(k_range+p1b-1),int_mb(k_range+h11b-
     &1),3,4,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y1_16',3,MA_ER
     &R)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_16',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsdtq_y1_16',5,MA_ERR)
      IF ((h11b .lt. h2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h12b_
     &2 - 1 + (noab+nvab) * (h9b_2 - 1 + (noab+nvab) * (h2b_2 - 1 + (noa
     &b+nvab) * (h11b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h2b-1),int_mb(k_range+h9b-1),int_mb(k_range+h12b-
     &1),2,1,4,3,-1.0d0)
      END IF
      IF ((h2b .le. h11b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h12b_
     &2 - 1 + (noab+nvab) * (h9b_2 - 1 + (noab+nvab) * (h11b_2 - 1 + (no
     &ab+nvab) * (h2b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h9b-1),int_mb(k_range+h12b-
     &1),1,2,4,3,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsdtq_y1_16',6,MA_ER
     &R)
      nsuperh(1) = 1
      nsuperh(2) = 1
      isuperh = 1
      IF (h9b .eq. h12b) THEN
      nsuperh(isuperh) = nsuperh(isuperh) + 1
      ELSE
      isuperh = isuperh + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperh(1))/FACTORIAL(nsuperh(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsdtq_y1_16',7,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y1_16',8,
     &MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y1_16',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h2b-1)
     &,int_mb(k_range+p1b-1),1,2,1.0d0/4.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p1b -
     & noab - 1 + nvab * (h2b - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y1_16',10,MA_E
     &RR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsdtq_y1_16',11
     &,MA_ERR)
      END IF
      END IF
      END IF
      next = NXTVAL(nprocs)
      END IF
      count = count + 1
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
