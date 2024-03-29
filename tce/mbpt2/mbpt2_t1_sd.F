      SUBROUTINE mbpt2_t1_sd(d_f1,d_i0,d_t11,d_t12,d_t21,d_v2,k_f1_offse
     &t,k_i0_offset,k_t11_offset,k_t12_offset,k_t21_offset,k_v2_offset)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_t2f + = -1 * Sum ( h2 ) * t2 ( p1 h2 )_t2 * f ( h2 h9 )_f
C     i0 ( p1 h9 )_t2f + = 1 * Sum ( p2 ) * t2 ( p2 h9 )_t2 * f ( p1 p2 )_f
C     i0 ( p1 h9 )_vt1 + = -1 * Sum ( h3 p2 ) * t1 ( p2 h3 )_t1 * v ( h3 p1 h9 p2 )_v
C     i0 ( p1 h9 )_vt1 + = -1/2 * Sum ( h3 h4 p2 ) * t1 ( p1 p2 h3 h4 )_t1 * v ( h3 h4 h9 p2 )_v
C     i0 ( p1 h9 )_vt1 + = 1/2 * Sum ( h4 p2 p3 ) * t1 ( p2 p3 h4 h9 )_t1 * v ( h4 p1 p2 p3 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_i0
      INTEGER k_i0_offset
      INTEGER d_t21
      INTEGER k_t21_offset
      INTEGER d_f1
      INTEGER k_f1_offset
      INTEGER d_t11
      INTEGER k_t11_offset
      INTEGER d_v2
      INTEGER k_v2_offset
      INTEGER d_t12
      INTEGER k_t12_offset
      CALL mbpt2_t1_sd_1(d_t21,k_t21_offset,d_f1,k_f1_offset,d_i0,k_i0_o
     &ffset)
      CALL mbpt2_t1_sd_2(d_t21,k_t21_offset,d_f1,k_f1_offset,d_i0,k_i0_o
     &ffset)
      CALL mbpt2_t1_sd_3(d_t11,k_t11_offset,d_v2,k_v2_offset,d_i0,k_i0_o
     &ffset)
      CALL mbpt2_t1_sd_4(d_t12,k_t12_offset,d_v2,k_v2_offset,d_i0,k_i0_o
     &ffset)
      CALL mbpt2_t1_sd_5(d_t12,k_t12_offset,d_v2,k_v2_offset,d_i0,k_i0_o
     &ffset)
      RETURN
      END
      SUBROUTINE mbpt2_t1_sd_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_t2f + = -1 * Sum ( h2 ) * t2 ( p1 h2 )_t2 * f ( h2 h9 )_f
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
      INTEGER nxtask
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p1b
      INTEGER h9b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h2b
      INTEGER p1b_1
      INTEGER h2b_1
      INTEGER h2b_2
      INTEGER h9b_2
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
      EXTERNAL nxtask
      nprocs = GA_NNODES()
      count = 0
      next = nxtask(nprocs,1)
      DO p1b = noab+1,noab+nvab
      DO h9b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h9b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h9b-1)) .eq. ieor(irrep_
     &t2,irrep_f)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h2b = 1,noab
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h2b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h2b-1)) .eq. irrep_t2) T
     &HEN
      CALL TCE_RESTRICTED_2(p1b,h2b,p1b_1,h2b_1)
      CALL TCE_RESTRICTED_2(h2b,h9b,h2b_2,h9b_2)
      dim_common = int_mb(k_range+h2b-1)
      dima_sort = int_mb(k_range+p1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h9b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &mbpt2_t1_sd_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h2b_1
     & - 1 + noab * (p1b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h2b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('mbpt2_t1_sd_1',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &mbpt2_t1_sd_1',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h9b_2
     & - 1 + (noab+nvab) * (h2b_2 - 1)))
      CALL TCE_SORT_2(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h9b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('mbpt2_t1_sd_1',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('mbpt2_t1_sd_1',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('mbpt2_t1_sd_1',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &mbpt2_t1_sd_1',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h9b-1)
     &,int_mb(k_range+p1b-1),2,1,-1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h9b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('mbpt2_t1_sd_1',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('mbpt2_t1_sd_1',11,M
     &A_ERR)
      END IF
      END IF
      END IF
      next = nxtask(nprocs,1)
      END IF
      count = count + 1
      END DO
      END DO
      next = nxtask(-nprocs,1)
      call GA_SYNC()
      RETURN
      END
      SUBROUTINE mbpt2_t1_sd_2(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_t2f + = 1 * Sum ( p2 ) * t2 ( p2 h9 )_t2 * f ( p1 p2 )_f
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
      INTEGER nxtask
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p1b
      INTEGER h9b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p2b
      INTEGER p2b_1
      INTEGER h9b_1
      INTEGER p1b_2
      INTEGER p2b_2
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
      EXTERNAL nxtask
      nprocs = GA_NNODES()
      count = 0
      next = nxtask(nprocs,1)
      DO p1b = noab+1,noab+nvab
      DO h9b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h9b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h9b-1)) .eq. ieor(irrep_
     &t2,irrep_f)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_2',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p2b = noab+1,noab+nvab
      IF (int_mb(k_spin+p2b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p2b-1),int_mb(k_sym+h9b-1)) .eq. irrep_t2) T
     &HEN
      CALL TCE_RESTRICTED_2(p2b,h9b,p2b_1,h9b_1)
      CALL TCE_RESTRICTED_2(p1b,p2b,p1b_2,p2b_2)
      dim_common = int_mb(k_range+p2b-1)
      dima_sort = int_mb(k_range+h9b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p1b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_2',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &mbpt2_t1_sd_2',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h9b_1
     & - 1 + noab * (p2b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p2b-1)
     &,int_mb(k_range+h9b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('mbpt2_t1_sd_2',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_2',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &mbpt2_t1_sd_2',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p2b_2
     & - 1 + (noab+nvab) * (p1b_2 - 1)))
      CALL TCE_SORT_2(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('mbpt2_t1_sd_2',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('mbpt2_t1_sd_2',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('mbpt2_t1_sd_2',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &mbpt2_t1_sd_2',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h9b-1),1,2,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h9b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('mbpt2_t1_sd_2',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('mbpt2_t1_sd_2',11,M
     &A_ERR)
      END IF
      END IF
      END IF
      next = nxtask(nprocs,1)
      END IF
      count = count + 1
      END DO
      END DO
      next = nxtask(-nprocs,1)
      call GA_SYNC()
      RETURN
      END
      SUBROUTINE mbpt2_t1_sd_3(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_vt1 + = -1 * Sum ( h3 p2 ) * t1 ( p2 h3 )_t1 * v ( h3 p1 h9 p2 )_v
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
      INTEGER nxtask
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p1b
      INTEGER h9b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p2b
      INTEGER h3b
      INTEGER p2b_1
      INTEGER h3b_1
      INTEGER p1b_2
      INTEGER h3b_2
      INTEGER h9b_2
      INTEGER p2b_2
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
      EXTERNAL nxtask
      nprocs = GA_NNODES()
      count = 0
      next = nxtask(nprocs,1)
      DO p1b = noab+1,noab+nvab
      DO h9b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h9b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h9b-1)) .eq. ieor(irrep_
     &v,irrep_t1)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_3',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p2b = noab+1,noab+nvab
      DO h3b = 1,noab
      IF (int_mb(k_spin+p2b-1) .eq. int_mb(k_spin+h3b-1)) THEN
      IF (ieor(int_mb(k_sym+p2b-1),int_mb(k_sym+h3b-1)) .eq. irrep_t1) T
     &HEN
      CALL TCE_RESTRICTED_2(p2b,h3b,p2b_1,h3b_1)
      CALL TCE_RESTRICTED_4(p1b,h3b,h9b,p2b,p1b_2,h3b_2,h9b_2,p2b_2)
      dim_common = int_mb(k_range+p2b-1) * int_mb(k_range+h3b-1)
      dima_sort = 1
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_3',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &mbpt2_t1_sd_3',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h3b_1
     & - 1 + noab * (p2b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p2b-1)
     &,int_mb(k_range+h3b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('mbpt2_t1_sd_3',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_3',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &mbpt2_t1_sd_3',5,MA_ERR)
      IF ((h3b .le. p1b) .and. (h9b .le. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p2b_2
     & - 1 + (noab+nvab) * (h9b_2 - 1 + (noab+nvab) * (p1b_2 - 1 + (noab
     &+nvab) * (h3b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+h9b-1),int_mb(k_range+p2b-1)
     &,3,2,1,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('mbpt2_t1_sd_3',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('mbpt2_t1_sd_3',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('mbpt2_t1_sd_3',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &mbpt2_t1_sd_3',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h9b-1)
     &,int_mb(k_range+p1b-1),2,1,-1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h9b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('mbpt2_t1_sd_3',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('mbpt2_t1_sd_3',11,M
     &A_ERR)
      END IF
      END IF
      END IF
      next = nxtask(nprocs,1)
      END IF
      count = count + 1
      END DO
      END DO
      next = nxtask(-nprocs,1)
      call GA_SYNC()
      RETURN
      END
      SUBROUTINE mbpt2_t1_sd_4(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_vt1 + = -1/2 * Sum ( h3 h4 p2 ) * t1 ( p1 p2 h3 h4 )_t1 * v ( h3 h4 h9 p2 )_v
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
      INTEGER nxtask
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p1b
      INTEGER h9b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p2b
      INTEGER h3b
      INTEGER h4b
      INTEGER p1b_1
      INTEGER p2b_1
      INTEGER h3b_1
      INTEGER h4b_1
      INTEGER h3b_2
      INTEGER h4b_2
      INTEGER h9b_2
      INTEGER p2b_2
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
      EXTERNAL nxtask
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = nxtask(nprocs,1)
      DO p1b = noab+1,noab+nvab
      DO h9b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h9b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h9b-1)) .eq. ieor(irrep_
     &v,irrep_t1)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_4',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p2b = noab+1,noab+nvab
      DO h3b = 1,noab
      DO h4b = h3b,noab
      IF (int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1) .eq. int_mb(k_spin+h
     &3b-1)+int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),ieor(int_mb(k_sym+p2b-1),ieor(int_mb(
     &k_sym+h3b-1),int_mb(k_sym+h4b-1)))) .eq. irrep_t1) THEN
      CALL TCE_RESTRICTED_4(p1b,p2b,h3b,h4b,p1b_1,p2b_1,h3b_1,h4b_1)
      CALL TCE_RESTRICTED_4(h3b,h4b,h9b,p2b,h3b_2,h4b_2,h9b_2,p2b_2)
      dim_common = int_mb(k_range+p2b-1) * int_mb(k_range+h3b-1) * int_m
     &b(k_range+h4b-1)
      dima_sort = int_mb(k_range+p1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h9b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_4',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &mbpt2_t1_sd_4',2,MA_ERR)
      IF ((p2b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (h3b_1 - 1 + noab * (p1b_1 - noab - 1 + nvab * (p2b_
     &1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p2b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1)
     &,2,4,3,1,-1.0d0)
      END IF
      IF ((p1b .le. p2b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (h3b_1 - 1 + noab * (p2b_1 - noab - 1 + nvab * (p1b_
     &1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+h3b-1),int_mb(k_range+h4b-1)
     &,1,4,3,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('mbpt2_t1_sd_4',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_4',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &mbpt2_t1_sd_4',5,MA_ERR)
      IF ((h9b .le. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p2b_2
     & - 1 + (noab+nvab) * (h9b_2 - 1 + (noab+nvab) * (h4b_2 - 1 + (noab
     &+nvab) * (h3b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h3b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h9b-1),int_mb(k_range+p2b-1)
     &,3,2,1,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('mbpt2_t1_sd_4',6,MA_ERR)
      nsubh(1) = 1
      nsubh(2) = 1
      isubh = 1
      IF (h3b .eq. h4b) THEN
      nsubh(isubh) = nsubh(isubh) + 1
      ELSE
      isubh = isubh + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsubh(1))/FACTORIAL(nsubh(2)),dbl_mb(k_a_sort),dim_common,dbl_mb(k
     &_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('mbpt2_t1_sd_4',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('mbpt2_t1_sd_4',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &mbpt2_t1_sd_4',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h9b-1)
     &,int_mb(k_range+p1b-1),2,1,-1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h9b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('mbpt2_t1_sd_4',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('mbpt2_t1_sd_4',11,M
     &A_ERR)
      END IF
      END IF
      END IF
      next = nxtask(nprocs,1)
      END IF
      count = count + 1
      END DO
      END DO
      next = nxtask(-nprocs,1)
      call GA_SYNC()
      RETURN
      END
      SUBROUTINE mbpt2_t1_sd_5(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: tce.py,v 1.10 2002/12/01 21:37:34 sohirata Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p1 h9 )_vt1 + = 1/2 * Sum ( h4 p2 p3 ) * t1 ( p2 p3 h4 h9 )_t1 * v ( h4 p1 p2 p3 )_v
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
      INTEGER nxtask
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER p1b
      INTEGER h9b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p2b
      INTEGER p3b
      INTEGER h4b
      INTEGER p2b_1
      INTEGER p3b_1
      INTEGER h9b_1
      INTEGER h4b_1
      INTEGER p1b_2
      INTEGER h4b_2
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
      INTEGER nsuperp(2)
      INTEGER isuperp
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL nxtask
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = nxtask(nprocs,1)
      DO p1b = noab+1,noab+nvab
      DO h9b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h9b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h9b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h9b-1)) .eq. ieor(irrep_
     &v,irrep_t1)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h9b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_5',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p2b = noab+1,noab+nvab
      DO p3b = p2b,noab+nvab
      DO h4b = 1,noab
      IF (int_mb(k_spin+p2b-1)+int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h
     &9b-1)+int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+p2b-1),ieor(int_mb(k_sym+p3b-1),ieor(int_mb(
     &k_sym+h9b-1),int_mb(k_sym+h4b-1)))) .eq. irrep_t1) THEN
      CALL TCE_RESTRICTED_4(p2b,p3b,h9b,h4b,p2b_1,p3b_1,h9b_1,h4b_1)
      CALL TCE_RESTRICTED_4(p1b,h4b,p2b,p3b,p1b_2,h4b_2,p2b_2,p3b_2)
      dim_common = int_mb(k_range+p2b-1) * int_mb(k_range+p3b-1) * int_m
     &b(k_range+h4b-1)
      dima_sort = int_mb(k_range+h9b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p1b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_5',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &mbpt2_t1_sd_5',2,MA_ERR)
      IF ((h4b .le. h9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h9b_1
     & - 1 + noab * (h4b_1 - 1 + noab * (p3b_1 - noab - 1 + nvab * (p2b_
     &1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p2b-1)
     &,int_mb(k_range+p3b-1),int_mb(k_range+h4b-1),int_mb(k_range+h9b-1)
     &,4,3,2,1,1.0d0)
      END IF
      IF ((h9b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (h9b_1 - 1 + noab * (p3b_1 - noab - 1 + nvab * (p2b_
     &1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p2b-1)
     &,int_mb(k_range+p3b-1),int_mb(k_range+h9b-1),int_mb(k_range+h4b-1)
     &,3,4,2,1,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('mbpt2_t1_sd_5',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('mbpt2_t1_sd_5',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &mbpt2_t1_sd_5',5,MA_ERR)
      IF ((h4b .le. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - 1 + (noab+nvab) * (p2b_2 - 1 + (noab+nvab) * (p1b_2 - 1 + (noab
     &+nvab) * (h4b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1)
     &,2,1,4,3,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('mbpt2_t1_sd_5',6,MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      isuperp = 1
      IF (p2b .eq. p3b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('mbpt2_t1_sd_5',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('mbpt2_t1_sd_5',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &mbpt2_t1_sd_5',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h9b-1),1,2,1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h9b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('mbpt2_t1_sd_5',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('mbpt2_t1_sd_5',11,M
     &A_ERR)
      END IF
      END IF
      END IF
      next = nxtask(nprocs,1)
      END IF
      count = count + 1
      END DO
      END DO
      next = nxtask(-nprocs,1)
      call GA_SYNC()
      RETURN
      END
