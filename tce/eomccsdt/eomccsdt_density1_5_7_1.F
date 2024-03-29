      SUBROUTINE eomccsdt_density1_5_7_1(d_a,k_a_offset,d_b,k_b_offset,d
     &_c,k_c_offset)
C     $Id: eomccsdt_density1_5_7_1.F,v 1.2 2006-02-27 19:28:59 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h6 h7 h8 h10 p4 p5 )_yt + = 1 * Sum ( p3 ) * t ( p3 h10 )_t * y ( h6 h7 h8 p3 p4 p5 )_y
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
      INTEGER h6b
      INTEGER h7b
      INTEGER h8b
      INTEGER h10b
      INTEGER p4b
      INTEGER p5b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p3b
      INTEGER p3b_1
      INTEGER h10b_1
      INTEGER h6b_2
      INTEGER h7b_2
      INTEGER h8b_2
      INTEGER p4b_2
      INTEGER p5b_2
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
      DO h6b = 1,noab
      DO h7b = h6b,noab
      DO h8b = h7b,noab
      DO h10b = 1,noab
      DO p4b = noab+1,noab+nvab
      DO p5b = p4b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h6b-1)+int_mb(k_spin+h7b-1
     &)+int_mb(k_spin+h8b-1)+int_mb(k_spin+h10b-1)+int_mb(k_spin+p4b-1)+
     &int_mb(k_spin+p5b-1).ne.12)) THEN
      IF (int_mb(k_spin+h6b-1)+int_mb(k_spin+h7b-1)+int_mb(k_spin+h8b-1)
     & .eq. int_mb(k_spin+h10b-1)+int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b
     &-1)) THEN
      IF (ieor(int_mb(k_sym+h6b-1),ieor(int_mb(k_sym+h7b-1),ieor(int_mb(
     &k_sym+h8b-1),ieor(int_mb(k_sym+h10b-1),ieor(int_mb(k_sym+p4b-1),in
     &t_mb(k_sym+p5b-1)))))) .eq. ieor(irrep_y,irrep_t)) THEN
      dimc = int_mb(k_range+h6b-1) * int_mb(k_range+h7b-1) * int_mb(k_ra
     &nge+h8b-1) * int_mb(k_range+h10b-1) * int_mb(k_range+p4b-1) * int_
     &mb(k_range+p5b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsdt_density1_5_7_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p3b = noab+1,noab+nvab
      IF (int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h10b-1)) THEN
      IF (ieor(int_mb(k_sym+p3b-1),int_mb(k_sym+h10b-1)) .eq. irrep_t) T
     &HEN
      CALL TCE_RESTRICTED_2(p3b,h10b,p3b_1,h10b_1)
      CALL TCE_RESTRICTED_6(h6b,h7b,h8b,p4b,p5b,p3b,h6b_2,h7b_2,h8b_2,p4
     &b_2,p5b_2,p3b_2)
      dim_common = int_mb(k_range+p3b-1)
      dima_sort = int_mb(k_range+h10b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h6b-1) * int_mb(k_range+h7b-1) * int_mb
     &(k_range+h8b-1) * int_mb(k_range+p4b-1) * int_mb(k_range+p5b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdt_density1_5_7_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdt_density1_5_7_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h10b_
     &1 - 1 + noab * (p3b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p3b-1)
     &,int_mb(k_range+h10b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdt_density1_5_7_1'
     &,3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsdt_density1_5_7_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsdt_density1_5_7_1',5,MA_ERR)
      IF ((p3b .le. p4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p4b_2 - noab - 1 + nvab * (p3b_2 - noab - 1 
     &+ nvab * (h8b_2 - 1 + noab * (h7b_2 - 1 + noab * (h6b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h6b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h8b-1),int_mb(k_range+p3b-1)
     &,int_mb(k_range+p4b-1),int_mb(k_range+p5b-1),6,5,3,2,1,4,1.0d0)
      END IF
      IF ((p4b .lt. p3b) .and. (p3b .le. p5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p5b_2
     & - noab - 1 + nvab * (p3b_2 - noab - 1 + nvab * (p4b_2 - noab - 1 
     &+ nvab * (h8b_2 - 1 + noab * (h7b_2 - 1 + noab * (h6b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h6b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h8b-1),int_mb(k_range+p4b-1)
     &,int_mb(k_range+p3b-1),int_mb(k_range+p5b-1),6,4,3,2,1,5,-1.0d0)
      END IF
      IF ((p5b .lt. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p4b_2 - noab - 1 
     &+ nvab * (h8b_2 - 1 + noab * (h7b_2 - 1 + noab * (h6b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h6b-1)
     &,int_mb(k_range+h7b-1),int_mb(k_range+h8b-1),int_mb(k_range+p4b-1)
     &,int_mb(k_range+p5b-1),int_mb(k_range+p3b-1),5,4,3,2,1,6,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsdt_density1_5_7_1'
     &,6,MA_ERR)
      CALL dgemm('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsdt_density1_5
     &_7_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdt_density1_5
     &_7_1',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdt_density1_5_7_1',9,MA_ERR)
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p4b-1),int_mb(k_range+h8b-1),int_mb(k_range+h7b-1)
     &,int_mb(k_range+h6b-1),int_mb(k_range+h10b-1),5,4,3,6,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p5b -
     & noab - 1 + nvab * (p4b - noab - 1 + nvab * (h10b - 1 + noab * (h8
     &b - 1 + noab * (h7b - 1 + noab * (h6b - 1)))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdt_density1_5_7_1'
     &,10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsdt_density1_5
     &_7_1',11,MA_ERR)
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
