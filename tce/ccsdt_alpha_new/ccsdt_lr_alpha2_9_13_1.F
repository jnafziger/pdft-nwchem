      SUBROUTINE ccsdt_lr_alpha2_9_13_1(d_a,k_a_offset,d_b,k_b_offset,d_
     &c,k_c_offset)
C     $Id: ccsdt_lr_alpha2_9_13_1.F,v 1.1 2008-09-17 03:18:52 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h2 h4 h13 h14 h15 p6 )_ytra + = -1 * Sum ( p7 p8 ) * tra ( p7 p8 h14 h15 )_tra * y ( h2 h4 h13 p6 p7 p8 )_y
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
      INTEGER h4b
      INTEGER h13b
      INTEGER h14b
      INTEGER h15b
      INTEGER p6b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p7b
      INTEGER p8b
      INTEGER p7b_1
      INTEGER p8b_1
      INTEGER h14b_1
      INTEGER h15b_1
      INTEGER h2b_2
      INTEGER h4b_2
      INTEGER h13b_2
      INTEGER p6b_2
      INTEGER p7b_2
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
      DO h2b = 1,noab
      DO h4b = h2b,noab
      DO h13b = h4b,noab
      DO h14b = 1,noab
      DO h15b = h14b,noab
      DO p6b = noab+1,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1
     &)+int_mb(k_spin+h13b-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1
     &)+int_mb(k_spin+p6b-1).ne.12)) THEN
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1)+int_mb(k_spin+h13b-1
     &) .eq. int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1)+int_mb(k_spin+p
     &6b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h4b-1),ieor(int_mb(
     &k_sym+h13b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+h15b-1),
     &int_mb(k_sym+p6b-1)))))) .eq. ieor(irrep_y,irrep_tra)) THEN
      dimc = int_mb(k_range+h2b-1) * int_mb(k_range+h4b-1) * int_mb(k_ra
     &nge+h13b-1) * int_mb(k_range+h14b-1) * int_mb(k_range+h15b-1) * in
     &t_mb(k_range+p6b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_13_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p7b = noab+1,noab+nvab
      DO p8b = p7b,noab+nvab
      IF (int_mb(k_spin+p7b-1)+int_mb(k_spin+p8b-1) .eq. int_mb(k_spin+h
     &14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+p7b-1),ieor(int_mb(k_sym+p8b-1),ieor(int_mb(
     &k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. irrep_tra) THEN
      CALL TCE_RESTRICTED_4(p7b,p8b,h14b,h15b,p7b_1,p8b_1,h14b_1,h15b_1)
      CALL TCE_RESTRICTED_6(h2b,h4b,h13b,p6b,p7b,p8b,h2b_2,h4b_2,h13b_2,
     &p6b_2,p7b_2,p8b_2)
      dim_common = int_mb(k_range+p7b-1) * int_mb(k_range+p8b-1)
      dima_sort = int_mb(k_range+h14b-1) * int_mb(k_range+h15b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h2b-1) * int_mb(k_range+h4b-1) * int_mb
     &(k_range+h13b-1) * int_mb(k_range+p6b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_13_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_13_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h15b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (p8b_1 - noab - 1 + nvab * (p7
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p7b-1)
     &,int_mb(k_range+p8b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),4,3,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lr_alpha2_9_13_1',
     &3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_13_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_13_1',5,MA_ERR)
      IF ((p8b .lt. p6b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - noab - 1 + nvab * (p8b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (h13b_2 - 1 + noab * (h4b_2 - 1 + noab * (h2b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+p8b-1),int_mb(k_range+p6b-1),6,3,2,1,5,4,1.0d0)
      END IF
      IF ((p7b .lt. p6b) .and. (p6b .le. p8b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p8b_2
     & - noab - 1 + nvab * (p6b_2 - noab - 1 + nvab * (p7b_2 - noab - 1 
     &+ nvab * (h13b_2 - 1 + noab * (h4b_2 - 1 + noab * (h2b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),int_mb(k_range+p7b-1
     &),int_mb(k_range+p6b-1),int_mb(k_range+p8b-1),5,3,2,1,6,4,-1.0d0)
      END IF
      IF ((p6b .le. p7b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p8b_2
     & - noab - 1 + nvab * (p7b_2 - noab - 1 + nvab * (p6b_2 - noab - 1 
     &+ nvab * (h13b_2 - 1 + noab * (h4b_2 - 1 + noab * (h2b_2 - 1))))))
     &)
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),int_mb(k_range+p6b-1
     &),int_mb(k_range+p7b-1),int_mb(k_range+p8b-1),4,3,2,1,6,5,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lr_alpha2_9_13_1',
     &6,MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      isuperp = 1
      IF (p7b .eq. p8b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_1
     &3_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_1
     &3_1',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_13_1',9,MA_ERR)
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p6b-1)
     &,int_mb(k_range+h13b-1),int_mb(k_range+h4b-1),int_mb(k_range+h2b-1
     &),int_mb(k_range+h15b-1),int_mb(k_range+h14b-1),4,3,2,6,5,1,-1.0d0
     &)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p6b -
     & noab - 1 + nvab * (h15b - 1 + noab * (h14b - 1 + noab * (h13b - 1
     & + noab * (h4b - 1 + noab * (h2b - 1)))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lr_alpha2_9_13_1',
     &10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_1
     &3_1',11,MA_ERR)
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
