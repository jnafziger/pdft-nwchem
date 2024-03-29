      SUBROUTINE ccsdtq_lr_alpha_15_18_3(d_a,k_a_offset,d_b,k_b_offset,d
     &_c,k_c_offset)
C     $Id: ccsdtq_lr_alpha_15_18_3.F,v 1.1 2007-10-29 02:25:42 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h12 p17 h15 h16 )_ytrbt + = 12 * Sum ( h8 p6 ) * t ( p6 p17 h8 h15 )_t * i3 ( h8 h12 h16 p6 )_ytrb
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
      INTEGER p17b
      INTEGER h12b
      INTEGER h15b
      INTEGER h16b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p6b
      INTEGER h8b
      INTEGER p17b_1
      INTEGER p6b_1
      INTEGER h15b_1
      INTEGER h8b_1
      INTEGER h12b_2
      INTEGER h8b_2
      INTEGER h16b_2
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
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p17b = noab+1,noab+nvab
      DO h12b = 1,noab
      DO h15b = 1,noab
      DO h16b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h12b-1)+int_mb(k_spin+p17b
     &-1)+int_mb(k_spin+h15b-1)+int_mb(k_spin+h16b-1).ne.8)) THEN
      IF (int_mb(k_spin+h12b-1)+int_mb(k_spin+p17b-1) .eq. int_mb(k_spin
     &+h15b-1)+int_mb(k_spin+h16b-1)) THEN
      IF (ieor(int_mb(k_sym+h12b-1),ieor(int_mb(k_sym+p17b-1),ieor(int_m
     &b(k_sym+h15b-1),int_mb(k_sym+h16b-1)))) .eq. ieor(irrep_y,ieor(irr
     &ep_trb,irrep_t))) THEN
      dimc = int_mb(k_range+h12b-1) * int_mb(k_range+p17b-1) * int_mb(k_
     &range+h15b-1) * int_mb(k_range+h16b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdtq_lr_alpha_15_18_3',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p6b = noab+1,noab+nvab
      DO h8b = 1,noab
      IF (int_mb(k_spin+p17b-1)+int_mb(k_spin+p6b-1) .eq. int_mb(k_spin+
     &h15b-1)+int_mb(k_spin+h8b-1)) THEN
      IF (ieor(int_mb(k_sym+p17b-1),ieor(int_mb(k_sym+p6b-1),ieor(int_mb
     &(k_sym+h15b-1),int_mb(k_sym+h8b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p17b,p6b,h15b,h8b,p17b_1,p6b_1,h15b_1,h8b_1)
      CALL TCE_RESTRICTED_4(h12b,h8b,h16b,p6b,h12b_2,h8b_2,h16b_2,p6b_2)
      dim_common = int_mb(k_range+p6b-1) * int_mb(k_range+h8b-1)
      dima_sort = int_mb(k_range+p17b-1) * int_mb(k_range+h15b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h12b-1) * int_mb(k_range+h16b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdtq_lr_alpha_15_18_3',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdtq_lr_alpha_15_18_3',2,MA_ERR)
      IF ((p6b .le. p17b) .and. (h8b .le. h15b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h15b_
     &1 - 1 + noab * (h8b_1 - 1 + noab * (p17b_1 - noab - 1 + nvab * (p6
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p6b-1)
     &,int_mb(k_range+p17b-1),int_mb(k_range+h8b-1),int_mb(k_range+h15b-
     &1),4,2,3,1,1.0d0)
      END IF
      IF ((p6b .le. p17b) .and. (h15b .lt. h8b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h8b_1
     & - 1 + noab * (h15b_1 - 1 + noab * (p17b_1 - noab - 1 + nvab * (p6
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p6b-1)
     &,int_mb(k_range+p17b-1),int_mb(k_range+h15b-1),int_mb(k_range+h8b-
     &1),3,2,4,1,-1.0d0)
      END IF
      IF ((p17b .lt. p6b) .and. (h8b .le. h15b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h15b_
     &1 - 1 + noab * (h8b_1 - 1 + noab * (p6b_1 - noab - 1 + nvab * (p17
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p17b-1
     &),int_mb(k_range+p6b-1),int_mb(k_range+h8b-1),int_mb(k_range+h15b-
     &1),4,1,3,2,-1.0d0)
      END IF
      IF ((p17b .lt. p6b) .and. (h15b .lt. h8b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h8b_1
     & - 1 + noab * (h15b_1 - 1 + noab * (p6b_1 - noab - 1 + nvab * (p17
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p17b-1
     &),int_mb(k_range+p6b-1),int_mb(k_range+h15b-1),int_mb(k_range+h8b-
     &1),3,1,4,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdtq_lr_alpha_15_18_3'
     &,3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdtq_lr_alpha_15_18_3',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdtq_lr_alpha_15_18_3',5,MA_ERR)
      IF ((h8b .le. h12b) .and. (h16b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - noab - 1 + nvab * (h16b_2 - 1 + noab * (h12b_2 - 1 + noab * (h8
     &b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h8b-1)
     &,int_mb(k_range+h12b-1),int_mb(k_range+h16b-1),int_mb(k_range+p6b-
     &1),3,2,1,4,1.0d0)
      END IF
      IF ((h12b .lt. h8b) .and. (h16b .le. p6b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - noab - 1 + nvab * (h16b_2 - 1 + noab * (h8b_2 - 1 + noab * (h12
     &b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h12b-1
     &),int_mb(k_range+h8b-1),int_mb(k_range+h16b-1),int_mb(k_range+p6b-
     &1),3,1,2,4,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdtq_lr_alpha_15_18_3'
     &,6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdtq_lr_alpha_15_
     &18_3',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdtq_lr_alpha_15_
     &18_3',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdtq_lr_alpha_15_18_3',9,MA_ERR)
      IF ((h15b .le. h16b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h16b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h15b-1),int_mb(k_range+p17
     &b-1),2,4,3,1,6.0d0/1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h16b 
     &- 1 + noab * (h15b - 1 + noab * (p17b - noab - 1 + nvab * (h12b - 
     &1)))))
      END IF
      IF ((h16b .le. h15b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h16b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h15b-1),int_mb(k_range+p17
     &b-1),2,4,1,3,-6.0d0/1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h15b 
     &- 1 + noab * (h16b - 1 + noab * (p17b - noab - 1 + nvab * (h12b - 
     &1)))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdtq_lr_alpha_15_18_3'
     &,10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdtq_lr_alpha_15_
     &18_3',11,MA_ERR)
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
