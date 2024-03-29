      SUBROUTINE wdm_hh_mo_d(d_i0,d_v2,d_z1,k_i0_offset,k_v2_offset,k_z1
     &_offset)
C     $Id: wdm_hh_mo_d.F,v 1.1 2008-09-30 19:42:52 d3p975 Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h1 h2 )_vz + = -2 * Sum ( h4 p3 ) * z ( p3 h4 )_z * v ( h1 h4 h2 p3 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_i0
      INTEGER k_i0_offset
      INTEGER d_z1
      INTEGER k_z1_offset
      INTEGER d_v2
      INTEGER k_v2_offset
      CALL wdm_hh_mo_d_1(d_z1,k_z1_offset,d_v2,k_v2_offset,d_i0,k_i0_off
     &set)
      RETURN
      END
      SUBROUTINE wdm_hh_mo_d_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_off
     &set)
C     $Id: wdm_hh_mo_d.F,v 1.1 2008-09-30 19:42:52 d3p975 Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h1 h2 )_vz + = -2 * Sum ( h4 p3 ) * z ( p3 h4 )_z * v ( h1 h4 h2 p3 )_v
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
      INTEGER h1b
      INTEGER h2b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p3b
      INTEGER h4b
      INTEGER p3b_1
      INTEGER h4b_1
      INTEGER h1b_2
      INTEGER h4b_2
      INTEGER h2b_2
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
c
      integer irrep_z
c
      nprocs = GA_NNODES()
      count = 0
      irrep_z=0
      next = NXTVAL(nprocs)
      DO h1b = 1,noab
      DO h2b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h1b-1)+int_mb(k_spin+h2b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+h1b-1) .eq. int_mb(k_spin+h2b-1)) THEN
      IF (ieor(int_mb(k_sym+h1b-1),int_mb(k_sym+h2b-1)) .eq. ieor(irrep_
     &v,irrep_z)) THEN
      dimc = int_mb(k_range+h1b-1) * int_mb(k_range+h2b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('wdm_hh_mo_d_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p3b = noab+1,noab+nvab
      DO h4b = 1,noab
      IF (int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+p3b-1),int_mb(k_sym+h4b-1)) .eq. irrep_z) TH
     &EN
      CALL TCE_RESTRICTED_2(p3b,h4b,p3b_1,h4b_1)
      CALL TCE_RESTRICTED_4(h1b,h4b,h2b,p3b,h1b_2,h4b_2,h2b_2,p3b_2)
      dim_common = int_mb(k_range+p3b-1) * int_mb(k_range+h4b-1)
      dima_sort = 1
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h1b-1) * int_mb(k_range+h2b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('wdm_hh_mo_d_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &wdm_hh_mo_d_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h4b_1
     & - 1 + noab * (p3b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p3b-1)
     &,int_mb(k_range+h4b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('wdm_hh_mo_d_1',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('wdm_hh_mo_d_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &wdm_hh_mo_d_1',5,MA_ERR)
      IF ((h4b .lt. h1b) .and. (h2b .le. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - 1 + (noab+nvab) * (h2b_2 - 1 + (noab+nvab) * (h1b_2 - 1 + (noab
     &+nvab) * (h4b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h1b-1),int_mb(k_range+h2b-1),int_mb(k_range+p3b-1)
     &,3,2,1,4,-1.0d0)
      END IF
      IF ((h1b .le. h4b) .and. (h2b .le. p3b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - 1 + (noab+nvab) * (h2b_2 - 1 + (noab+nvab) * (h4b_2 - 1 + (noab
     &+nvab) * (h1b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h1b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h2b-1),int_mb(k_range+p3b-1)
     &,3,1,2,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('wdm_hh_mo_d_1',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('wdm_hh_mo_d_1',7,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('wdm_hh_mo_d_1',8,MA
     &_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &wdm_hh_mo_d_1',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h2b-1)
     &,int_mb(k_range+h1b-1),2,1,-2.0d0/1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h2b -
     & 1 + noab * (h1b - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('wdm_hh_mo_d_1',10,MA_ERR
     &)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('wdm_hh_mo_d_1',11,M
     &A_ERR)
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
