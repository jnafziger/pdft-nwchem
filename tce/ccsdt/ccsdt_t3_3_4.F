      SUBROUTINE ccsdt_t3_3_4(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_offs
     &et)
C     $Id: ccsdt_t3_3_4.F,v 1.3 2005-12-19 18:51:44 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h11 h1 )_vt + = -1/2 * Sum ( h10 p8 p9 ) * t ( p8 p9 h1 h10 )_t * v ( h10 h11 p8 p9 )_v
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
      INTEGER h11b
      INTEGER h1b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p8b
      INTEGER p9b
      INTEGER h10b
      INTEGER p8b_1
      INTEGER p9b_1
      INTEGER h1b_1
      INTEGER h10b_1
      INTEGER h11b_2
      INTEGER h10b_2
      INTEGER p8b_2
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
      DO h11b = 1,noab
      DO h1b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h11b-1)+int_mb(k_spin+h1b-
     &1).ne.4)) THEN
      IF (int_mb(k_spin+h11b-1) .eq. int_mb(k_spin+h1b-1)) THEN
      IF (ieor(int_mb(k_sym+h11b-1),int_mb(k_sym+h1b-1)) .eq. ieor(irrep
     &_v,irrep_t)) THEN
      dimc = int_mb(k_range+h11b-1) * int_mb(k_range+h1b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_t3_3_4',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p8b = noab+1,noab+nvab
      DO p9b = p8b,noab+nvab
      DO h10b = 1,noab
      IF (int_mb(k_spin+p8b-1)+int_mb(k_spin+p9b-1) .eq. int_mb(k_spin+h
     &1b-1)+int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p8b-1),ieor(int_mb(k_sym+p9b-1),ieor(int_mb(
     &k_sym+h1b-1),int_mb(k_sym+h10b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p8b,p9b,h1b,h10b,p8b_1,p9b_1,h1b_1,h10b_1)
      CALL TCE_RESTRICTED_4(h11b,h10b,p8b,p9b,h11b_2,h10b_2,p8b_2,p9b_2)
      dim_common = int_mb(k_range+p8b-1) * int_mb(k_range+p9b-1) * int_m
     &b(k_range+h10b-1)
      dima_sort = int_mb(k_range+h1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h11b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_t3_3_4',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_t3_3_4',2,MA_ERR)
      IF ((h10b .lt. h1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h1b_1
     & - 1 + noab * (h10b_1 - 1 + noab * (p9b_1 - noab - 1 + nvab * (p8b
     &_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p9b-1),int_mb(k_range+h10b-1),int_mb(k_range+h1b-1
     &),4,3,2,1,-1.0d0)
      END IF
      IF ((h1b .le. h10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (h1b_1 - 1 + noab * (p9b_1 - noab - 1 + nvab * (p8b
     &_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p9b-1),int_mb(k_range+h1b-1),int_mb(k_range+h10b-1
     &),3,4,2,1,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_t3_3_4',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_t3_3_4',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_t3_3_4',5,MA_ERR)
      IF ((h10b .le. h11b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - 1 + (noab+nvab) * (p8b_2 - 1 + (noab+nvab) * (h11b_2 - 1 + (noa
     &b+nvab) * (h10b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+h11b-1),int_mb(k_range+p8b-1),int_mb(k_range+p9b-
     &1),2,1,4,3,1.0d0)
      END IF
      IF ((h11b .lt. h10b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - 1 + (noab+nvab) * (p8b_2 - 1 + (noab+nvab) * (h10b_2 - 1 + (noa
     &b+nvab) * (h11b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h11b-1
     &),int_mb(k_range+h10b-1),int_mb(k_range+p8b-1),int_mb(k_range+p9b-
     &1),1,2,4,3,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_t3_3_4',6,MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      isuperp = 1
      IF (p8b .eq. p9b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_t3_3_4',7,MA_
     &ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_t3_3_4',8,MA_
     &ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_t3_3_4',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h11b-1
     &),int_mb(k_range+h1b-1),1,2,-1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h1b -
     & 1 + noab * (h11b - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_t3_3_4',10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_t3_3_4',11,MA
     &_ERR)
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
