      SUBROUTINE ccsdt_lr_alpha_offdiag_15_31(d_a,k_a_offset,d_b,k_b_off
     &set,d_c,k_c_offset)
C     $Id: ccsdt_lr_alpha_offdiag_15_31.F,v 1.1 2007-08-11 01:25:00 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p11 p12 h14 h15 )_ybta + = -1/3 * a ( p12 h14 )_a * i2 ( p11 h15 )_ybt
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
      INTEGER p12b
      INTEGER p11b
      INTEGER h14b
      INTEGER h15b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p12b_1
      INTEGER h14b_1
      INTEGER p11b_2
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
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p12b = noab+1,noab+nvab
      DO p11b = noab+1,noab+nvab
      DO h14b = 1,noab
      DO h15b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p11b-1)+int_mb(k_spin+p12b
     &-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1).ne.8)) THEN
      IF (int_mb(k_spin+p11b-1)+int_mb(k_spin+p12b-1) .eq. int_mb(k_spin
     &+h14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+p11b-1),ieor(int_mb(k_sym+p12b-1),ieor(int_m
     &b(k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. ieor(irrep_y,ieor(irr
     &ep_b,ieor(irrep_t,irrep_a)))) THEN
      dimc = int_mb(k_range+p11b-1) * int_mb(k_range+p12b-1) * int_mb(k_
     &range+h14b-1) * int_mb(k_range+h15b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_15_31',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      IF (int_mb(k_spin+p12b-1) .eq. int_mb(k_spin+h14b-1)) THEN
      IF (ieor(int_mb(k_sym+p12b-1),int_mb(k_sym+h14b-1)) .eq. irrep_a) 
     &THEN
      CALL TCE_RESTRICTED_2(p12b,h14b,p12b_1,h14b_1)
      CALL TCE_RESTRICTED_2(p11b,h15b,p11b_2,h15b_2)
      dim_common = 1
      dima_sort = int_mb(k_range+p12b-1) * int_mb(k_range+h14b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p11b-1) * int_mb(k_range+h15b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_15_31',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_15_31',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h14b_
     &1 - 1 + noab * (p12b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p12b-1
     &),int_mb(k_range+h14b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &5_31',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lr_alpha_offdiag_15_31',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_15_31',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h15b_
     &2 - 1 + noab * (p11b_2 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p11b-1
     &),int_mb(k_range+h15b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &5_31',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_15_31',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_15_31',8,MA_ERR)
      END IF
      END IF
      END IF
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lr_alpha_offdiag_15_31',9,MA_ERR)
      IF ((p11b .le. p12b) .and. (h14b .le. h15b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h15b-1
     &),int_mb(k_range+p11b-1),int_mb(k_range+h14b-1),int_mb(k_range+p12
     &b-1),2,4,3,1,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h15b 
     &- 1 + noab * (h14b - 1 + noab * (p12b - noab - 1 + nvab * (p11b - 
     &noab - 1)))))
      END IF
      IF ((p11b .le. p12b) .and. (h15b .le. h14b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h15b-1
     &),int_mb(k_range+p11b-1),int_mb(k_range+h14b-1),int_mb(k_range+p12
     &b-1),2,4,1,3,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h14b 
     &- 1 + noab * (h15b - 1 + noab * (p12b - noab - 1 + nvab * (p11b - 
     &noab - 1)))))
      END IF
      IF ((p12b .le. p11b) .and. (h14b .le. h15b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h15b-1
     &),int_mb(k_range+p11b-1),int_mb(k_range+h14b-1),int_mb(k_range+p12
     &b-1),4,2,3,1,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h15b 
     &- 1 + noab * (h14b - 1 + noab * (p11b - noab - 1 + nvab * (p12b - 
     &noab - 1)))))
      END IF
      IF ((p12b .le. p11b) .and. (h15b .le. h14b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h15b-1
     &),int_mb(k_range+p11b-1),int_mb(k_range+h14b-1),int_mb(k_range+p12
     &b-1),4,2,1,3,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h14b 
     &- 1 + noab * (h15b - 1 + noab * (p11b - noab - 1 + nvab * (p12b - 
     &noab - 1)))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lr_alpha_offdiag_1
     &5_31',10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lr_alpha_offd
     &iag_15_31',11,MA_ERR)
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
