      SUBROUTINE ccsdt_lr_alpha_offdiag_13_7_2(d_a,k_a_offset,d_b,k_b_of
     &fset,d_c,k_c_offset)
C     $Id: ccsdt_lr_alpha_offdiag_13_7_2.F,v 1.1 2007-08-11 01:24:44 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h5 h13 h11 h12 )_yb + = -1/3 * Sum ( h4 p1 p2 p3 ) * b ( p1 p2 p3 h4 h11 h12 )_b * y ( h4 h5 h13 p1 p2 p3 )_y
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
      INTEGER h5b
      INTEGER h13b
      INTEGER h11b
      INTEGER h12b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p1b
      INTEGER p2b
      INTEGER p3b
      INTEGER h4b
      INTEGER p1b_1
      INTEGER p2b_1
      INTEGER p3b_1
      INTEGER h11b_1
      INTEGER h12b_1
      INTEGER h4b_1
      INTEGER h5b_2
      INTEGER h13b_2
      INTEGER h4b_2
      INTEGER p1b_2
      INTEGER p2b_2
      INTEGER p3b_2
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
      INTEGER nsuperp(3)
      INTEGER isuperp
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h5b = 1,noab
      DO h13b = h5b,noab
      DO h11b = 1,noab
      DO h12b = h11b,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h5b-1)+int_mb(k_spin+h13b-
     &1)+int_mb(k_spin+h11b-1)+int_mb(k_spin+h12b-1).ne.8)) THEN
      IF (int_mb(k_spin+h5b-1)+int_mb(k_spin+h13b-1) .eq. int_mb(k_spin+
     &h11b-1)+int_mb(k_spin+h12b-1)) THEN
      IF (ieor(int_mb(k_sym+h5b-1),ieor(int_mb(k_sym+h13b-1),ieor(int_mb
     &(k_sym+h11b-1),int_mb(k_sym+h12b-1)))) .eq. ieor(irrep_y,irrep_b))
     & THEN
      dimc = int_mb(k_range+h5b-1) * int_mb(k_range+h13b-1) * int_mb(k_r
     &ange+h11b-1) * int_mb(k_range+h12b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_13_7_2',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      DO p3b = p2b,noab+nvab
      DO h4b = 1,noab
      IF (int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+int_mb(k_spin+p3b-1)
     & .eq. int_mb(k_spin+h11b-1)+int_mb(k_spin+h12b-1)+int_mb(k_spin+h4
     &b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),ieor(int_mb(k_sym+p2b-1),ieor(int_mb(
     &k_sym+p3b-1),ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+h12b-1),i
     &nt_mb(k_sym+h4b-1)))))) .eq. irrep_b) THEN
      CALL TCE_RESTRICTED_6(p1b,p2b,p3b,h11b,h12b,h4b,p1b_1,p2b_1,p3b_1,
     &h11b_1,h12b_1,h4b_1)
      CALL TCE_RESTRICTED_6(h5b,h13b,h4b,p1b,p2b,p3b,h5b_2,h13b_2,h4b_2,
     &p1b_2,p2b_2,p3b_2)
      dim_common = int_mb(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_m
     &b(k_range+p3b-1) * int_mb(k_range+h4b-1)
      dima_sort = int_mb(k_range+h11b-1) * int_mb(k_range+h12b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h5b-1) * int_mb(k_range+h13b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_13_7_2',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_13_7_2',2,MA_ERR)
      IF ((h4b .le. h11b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h11b_1 - 1 + noab * (h4b_1 - 1 + noab * (p3b_1 - n
     &oab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1)))))
     &))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h11b-1),int_mb(k_range+h12b-1),6,5,4,3,2,1,1.0d0)
      END IF
      IF ((h11b .lt. h4b) .and. (h4b .le. h12b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h4b_1 - 1 + noab * (h11b_1 - 1 + noab * (p3b_1 - n
     &oab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1)))))
     &))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+h4b-1),int_mb(k_range+h12b-1),6,4,5,3,2,1,-1.0d0)
      END IF
      IF ((h12b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (h12b_1 - 1 + noab * (h11b_1 - 1 + noab * (p3b_1 - n
     &oab - 1 + nvab * (p2b_1 - noab - 1 + nvab * (p1b_1 - noab - 1)))))
     &))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),int_mb(k_range+h11b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h4b-1),5,4,6,3,2,1,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &3_7_2',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_13_7_2',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_13_7_2',5,MA_ERR)
      IF ((h4b .le. h5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (h13b_2 - 1 + noab * (h5b_2 - 1 + noab * (h4b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+h13b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),3,2,1,6,5,4,1.0d0)
      END IF
      IF ((h5b .lt. h4b) .and. (h4b .le. h13b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (h13b_2 - 1 + noab * (h4b_2 - 1 + noab * (h5b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),3,1,2,6,5,4,-1.0d0)
      END IF
      IF ((h13b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (h4b_2 - 1 + noab * (h13b_2 - 1 + noab * (h5b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1
     &),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1),2,1,3,6,5,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &3_7_2',6,MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      nsuperp(3) = 1
      isuperp = 1
      IF (p1b .eq. p2b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      IF (p2b .eq. p3b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,6.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2))/FACTORIAL(nsuperp(3)),dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_13_7_2',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_13_7_2',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_13_7_2',9,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+h5b-1),int_mb(k_range+h12b-1),int_mb(k_range+h11b
     &-1),2,1,4,3,-1.0d0/3.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h12b 
     &- 1 + noab * (h11b - 1 + noab * (h13b - 1 + noab * (h5b - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &3_7_2',10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_13_7_2',11,MA_ERR)
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
