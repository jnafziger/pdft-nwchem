      SUBROUTINE ccsdt_lr_alpha2_9_7(d_a,k_a_offset,d_b,k_b_offset,d_c,k
     &_c_offset)
C     $Id: ccsdt_lr_alpha2_9_7.F,v 1.1 2008-09-17 03:19:36 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p11 p12 h14 h15 )_ytrbtra + = 1/12 * Sum ( h2 h13 h4 p6 ) * tra ( p6 p11 p12 h2 h4 h13 )_tra * i2 ( h2 h4 h13 h14 h15 p6 )_ytrb
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
      INTEGER p11b
      INTEGER p12b
      INTEGER h14b
      INTEGER h15b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p6b
      INTEGER h2b
      INTEGER h4b
      INTEGER h13b
      INTEGER p11b_1
      INTEGER p12b_1
      INTEGER p6b_1
      INTEGER h2b_1
      INTEGER h4b_1
      INTEGER h13b_1
      INTEGER h2b_2
      INTEGER h4b_2
      INTEGER h13b_2
      INTEGER h14b_2
      INTEGER h15b_2
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
      INTEGER nsubh(3)
      INTEGER isubh
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p11b = noab+1,noab+nvab
      DO p12b = p11b,noab+nvab
      DO h14b = 1,noab
      DO h15b = h14b,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p11b-1)+int_mb(k_spin+p12b
     &-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1).ne.8)) THEN
      IF (int_mb(k_spin+p11b-1)+int_mb(k_spin+p12b-1) .eq. int_mb(k_spin
     &+h14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+p11b-1),ieor(int_mb(k_sym+p12b-1),ieor(int_m
     &b(k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. ieor(irrep_y,ieor(irr
     &ep_trb,irrep_tra))) THEN
      dimc = int_mb(k_range+p11b-1) * int_mb(k_range+p12b-1) * int_mb(k_
     &range+h14b-1) * int_mb(k_range+h15b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_7',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p6b = noab+1,noab+nvab
      DO h2b = 1,noab
      DO h4b = h2b,noab
      DO h13b = h4b,noab
      IF (int_mb(k_spin+p11b-1)+int_mb(k_spin+p12b-1)+int_mb(k_spin+p6b-
     &1) .eq. int_mb(k_spin+h2b-1)+int_mb(k_spin+h4b-1)+int_mb(k_spin+h1
     &3b-1)) THEN
      IF (ieor(int_mb(k_sym+p11b-1),ieor(int_mb(k_sym+p12b-1),ieor(int_m
     &b(k_sym+p6b-1),ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+h4b-1),i
     &nt_mb(k_sym+h13b-1)))))) .eq. irrep_tra) THEN
      CALL TCE_RESTRICTED_6(p11b,p12b,p6b,h2b,h4b,h13b,p11b_1,p12b_1,p6b
     &_1,h2b_1,h4b_1,h13b_1)
      CALL TCE_RESTRICTED_6(h2b,h4b,h13b,h14b,h15b,p6b,h2b_2,h4b_2,h13b_
     &2,h14b_2,h15b_2,p6b_2)
      dim_common = int_mb(k_range+p6b-1) * int_mb(k_range+h2b-1) * int_m
     &b(k_range+h4b-1) * int_mb(k_range+h13b-1)
      dima_sort = int_mb(k_range+p11b-1) * int_mb(k_range+p12b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h14b-1) * int_mb(k_range+h15b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_7',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_7',2,MA_ERR)
      IF ((p6b .le. p11b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h13b_
     &1 - 1 + noab * (h4b_1 - 1 + noab * (h2b_1 - 1 + noab * (p12b_1 - n
     &oab - 1 + nvab * (p11b_1 - noab - 1 + nvab * (p6b_1 - noab - 1))))
     &)))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p6b-1)
     &,int_mb(k_range+p11b-1),int_mb(k_range+p12b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),3,2,6,5,4,1,1.0d0)
      END IF
      IF ((p11b .lt. p6b) .and. (p6b .le. p12b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h13b_
     &1 - 1 + noab * (h4b_1 - 1 + noab * (h2b_1 - 1 + noab * (p12b_1 - n
     &oab - 1 + nvab * (p6b_1 - noab - 1 + nvab * (p11b_1 - noab - 1))))
     &)))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p11b-1
     &),int_mb(k_range+p6b-1),int_mb(k_range+p12b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),3,1,6,5,4,2,-1.0d0
     &)
      END IF
      IF ((p12b .lt. p6b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h13b_
     &1 - 1 + noab * (h4b_1 - 1 + noab * (h2b_1 - 1 + noab * (p6b_1 - no
     &ab - 1 + nvab * (p12b_1 - noab - 1 + nvab * (p11b_1 - noab - 1))))
     &)))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p11b-1
     &),int_mb(k_range+p12b-1),int_mb(k_range+p6b-1),int_mb(k_range+h2b-
     &1),int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),2,1,6,5,4,3,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7',3,M
     &A_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha2_9_7',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_7',5,MA_ERR)
      IF ((h15b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - noab - 1 + nvab * (h15b_2 - 1 + noab * (h14b_2 - 1 + noab * (h1
     &3b_2 - 1 + noab * (h4b_2 - 1 + noab * (h2b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h13b-1),int_mb(k_range+h14b-
     &1),int_mb(k_range+h15b-1),int_mb(k_range+p6b-1),5,4,3,2,1,6,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7',6,M
     &A_ERR)
      nsubh(1) = 1
      nsubh(2) = 1
      nsubh(3) = 1
      isubh = 1
      IF (h2b .eq. h4b) THEN
      nsubh(isubh) = nsubh(isubh) + 1
      ELSE
      isubh = isubh + 1
      END IF
      IF (h4b .eq. h13b) THEN
      nsubh(isubh) = nsubh(isubh) + 1
      ELSE
      isubh = isubh + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,6.0d0/FACTORIAL(
     &nsubh(1))/FACTORIAL(nsubh(2))/FACTORIAL(nsubh(3)),dbl_mb(k_a_sort)
     &,dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dim
     &a_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7
     &',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7
     &',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lr_alpha2_9_7',9,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h15b-1
     &),int_mb(k_range+h14b-1),int_mb(k_range+p12b-1),int_mb(k_range+p11
     &b-1),4,3,2,1,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h15b 
     &- 1 + noab * (h14b - 1 + noab * (p12b - noab - 1 + nvab * (p11b - 
     &noab - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7',10,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lr_alpha2_9_7
     &',11,MA_ERR)
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
