      SUBROUTINE ccsdt_lambda1_5_4(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c
     &_offset)
C     $Id: ccsdt_lambda1_5_4.F,v 1.3 2005-12-16 22:34:49 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p11 h10 )_vt + = -1 * Sum ( h4 p3 ) * t ( p3 h4 )_t * v ( h4 p11 h10 p3 )_v
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
      INTEGER h10b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p3b
      INTEGER h4b
      INTEGER p3b_1
      INTEGER h4b_1
      INTEGER p11b_2
      INTEGER h4b_2
      INTEGER h10b_2
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
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO p11b = noab+1,noab+nvab
      DO h10b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p11b-1)+int_mb(k_spin+h10b
     &-1).ne.4)) THEN
      IF (int_mb(k_spin+p11b-1) .eq. int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p11b-1),int_mb(k_sym+h10b-1)) .eq. ieor(irre
     &p_v,irrep_t)) THEN
      dimc = int_mb(k_range+p11b-1) * int_mb(k_range+h10b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lambda1_5_4',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p3b = noab+1,noab+nvab
      DO h4b = 1,noab
      IF (int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+p3b-1),int_mb(k_sym+h4b-1)) .eq. irrep_t) TH
     &EN
      CALL TCE_RESTRICTED_2(p3b,h4b,p3b_1,h4b_1)
      CALL TCE_RESTRICTED_4(p11b,h4b,h10b,p3b,p11b_2,h4b_2,h10b_2,p3b_2)
      dim_common = int_mb(k_range+p3b-1) * int_mb(k_range+h4b-1)
      dima_sort = 1
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p11b-1) * int_mb(k_range+h10b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lambda1_5_4',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lambda1_5_4',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (p3b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p3b-1)
     &,int_mb(k_range+h4b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lambda1_5_4',3,MA_
     &ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lambda1_5_4',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lambda1_5_4',5,MA_ERR)
      IF ((h4b .le. p11b) .and. (h10b .le. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - 1 + (noab+nvab) * (h10b_2 - 1 + (noab+nvab) * (p11b_2 - 1 + (no
     &ab+nvab) * (h4b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+p11b-1),int_mb(k_range+h10b-1),int_mb(k_range+p3b-
     &1),3,2,1,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lambda1_5_4',6,MA_
     &ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lambda1_5_4',
     &7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lambda1_5_4',
     &8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lambda1_5_4',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h10b-1
     &),int_mb(k_range+p11b-1),2,1,-1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h10b 
     &- 1 + noab * (p11b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lambda1_5_4',10,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lambda1_5_4',
     &11,MA_ERR)
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
