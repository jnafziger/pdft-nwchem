      SUBROUTINE ccsd_2pdm_hppp_mo(d_i0,d_t1,d_y2,k_i0_offset,k_t1_offse
     &t,k_y2_offset)
C     $Id: ccsd_2pdm_hppp_mo.F,v 1.1 2008-09-30 19:05:24 d3p975 Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h4 p1 p2 p3 )_yt + = -1/2 * P( 2 ) * Sum ( h5 ) * t ( p1 h5 )_t * y ( h4 h5 p2 p3 )_y
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_i0
      INTEGER k_i0_offset
      INTEGER d_t1
      INTEGER k_t1_offset
      INTEGER d_y2
      INTEGER k_y2_offset
      CALL ccsd_2pdm_hppp_mo_1(d_t1,k_t1_offset,d_y2,k_y2_offset,d_i0,k_
     &i0_offset)
      RETURN
      END
      SUBROUTINE ccsd_2pdm_hppp_mo_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k
     &_c_offset)
C     $Id: ccsd_2pdm_hppp_mo.F,v 1.1 2008-09-30 19:05:24 d3p975 Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h4 p1 p2 p3 )_yt + = -1/2 * P( 2 ) * Sum ( h5 ) * t ( p1 h5 )_t * y ( h4 h5 p2 p3 )_y
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
      INTEGER p1b
      INTEGER h4b
      INTEGER p2b
      INTEGER p3b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h5b
      INTEGER p1b_1
      INTEGER h5b_1
      INTEGER h4b_2
      INTEGER h5b_2
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
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h4b = 1,noab
      DO p1b = noab+1,noab+nvab
      DO p2b = noab+1,noab+nvab
      DO p3b = p2b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h4b-1)+int_mb(k_spin+p1b-1
     &)+int_mb(k_spin+p2b-1)+int_mb(k_spin+p3b-1).ne.8)) THEN
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+p
     &2b-1)+int_mb(k_spin+p3b-1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb(
     &k_sym+p2b-1),int_mb(k_sym+p3b-1)))) .eq. ieor(irrep_y,irrep_t)) TH
     &EN
      dimc = int_mb(k_range+h4b-1) * int_mb(k_range+p1b-1) * int_mb(k_ra
     &nge+p2b-1) * int_mb(k_range+p3b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsd_2pdm_hppp_mo_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h5b = 1,noab
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. irrep_t) TH
     &EN
      CALL TCE_RESTRICTED_2(p1b,h5b,p1b_1,h5b_1)
      CALL TCE_RESTRICTED_4(h4b,h5b,p2b,p3b,h4b_2,h5b_2,p2b_2,p3b_2)
      dim_common = int_mb(k_range+h5b-1)
      dima_sort = int_mb(k_range+p1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h4b-1) * int_mb(k_range+p2b-1) * int_mb
     &(k_range+p3b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsd_2pdm_hppp_mo_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsd_2pdm_hppp_mo_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h5b_1
     & - 1 + noab * (p1b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h5b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1',3,M
     &A_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsd_2pdm_hppp_mo_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsd_2pdm_hppp_mo_1',5,MA_ERR)
      IF ((h5b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab 
     &* (h5b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1)
     &,4,3,2,1,-1.0d0)
      END IF
      IF ((h4b .le. h5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (h5b_2 - 1 + noab 
     &* (h4b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1)
     &,4,3,1,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1',6,M
     &A_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1
     &',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1
     &',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsd_2pdm_hppp_mo_1',9,MA_ERR)
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
c     &,3,4,2,1,-1.0d0/2.0d0)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
     &,3,4,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (p1b - noab - 1 + nvab
     & * (h4b - 1)))))
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
c     &,4,3,2,1,1.0d0/2.0d0)
c      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
c     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (h4b - 1 + noab * (p1b
c     & - noab - 1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1',10,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsd_2pdm_hppp_mo_1
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
