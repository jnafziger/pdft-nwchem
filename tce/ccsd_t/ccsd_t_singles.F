      SUBROUTINE ccsd_t_singles(a_i0,d_t1,d_v2,k_t1_offset,k_v2_offset,t
     &_h1b,t_h2b,t_h3b,t_p4b,t_p5b,t_p6b,toggle)
C     $Id: ccsd_t_singles.F,v 1.4 2008-10-14 04:15:57 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p4 p5 p6 h1 h2 h3 )_vt + = 1 * P( 9 ) * t ( p4 h1 )_t * v ( p5 p6 h2 h3 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER t_p4b
      INTEGER t_p5b
      INTEGER t_p6b
      INTEGER t_h1b
      INTEGER t_h2b
      INTEGER t_h3b
      INTEGER toggle
      INTEGER d_t1
      INTEGER k_t1_offset
      INTEGER d_v2
      INTEGER k_v2_offset
      DOUBLE PRECISION a_i0(*)
      IF (toggle .eq. 2) CALL ccsd_t_singles_1(d_t1,k_t1_offset,d_v2,
     &   k_v2_offset,a_i0,t_p4b,t_p5b,t_p6b,t_h1b,t_h2b,t_h3b)
      RETURN
      END
      SUBROUTINE ccsd_t_singles_1(d_a,k_a_offset,d_b,k_b_offset,a_c,t_p4
     &b,t_p5b,t_p6b,t_h1b,t_h2b,t_h3b)
C     $Id: ccsd_t_singles.F,v 1.4 2008-10-14 04:15:57 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( p4 p5 p6 h1 h2 h3 )_vt + = 1 * P( 9 ) * t ( p4 h1 )_t * v ( p5 p6 h2 h3 )_v
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
      INTEGER t_p4b
      INTEGER t_p5b
      INTEGER t_p6b
      INTEGER t_h1b
      INTEGER t_h2b
      INTEGER t_h3b
      INTEGER p4b
      INTEGER p5b
      INTEGER p6b
      INTEGER h1b
      INTEGER h2b
      INTEGER h3b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p4b_1
      INTEGER h1b_1
      INTEGER p5b_2
      INTEGER p6b_2
      INTEGER h2b_2
      INTEGER h3b_2
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
      DOUBLE PRECISION a_c(*)
      LOGICAL skipped
      DO p4b = noab+1,noab+nvab
      DO p5b = noab+1,noab+nvab
      DO p6b = p5b,noab+nvab
      DO h1b = 1,noab
      DO h2b = 1,noab
      DO h3b = h2b,noab
      skipped = .true.
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) skipped = .false.
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) skipped = .false.
      IF (.not.skipped) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1
     &)+int_mb(k_spin+p6b-1)+int_mb(k_spin+h1b-1)+int_mb(k_spin+h2b-1)+i
     &nt_mb(k_spin+h3b-1).ne.12)) THEN
      IF (int_mb(k_spin+p4b-1)+int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1)
     & .eq. int_mb(k_spin+h1b-1)+int_mb(k_spin+h2b-1)+int_mb(k_spin+h3b-
     &1)) THEN
      IF (ieor(int_mb(k_sym+p4b-1),ieor(int_mb(k_sym+p5b-1),ieor(int_mb(
     &k_sym+p6b-1),ieor(int_mb(k_sym+h1b-1),ieor(int_mb(k_sym+h2b-1),int
     &_mb(k_sym+h3b-1)))))) .eq. ieor(irrep_v,irrep_t)) THEN
      dimc = int_mb(k_range+p4b-1) * int_mb(k_range+p5b-1) * int_mb(k_ra
     &nge+p6b-1) * int_mb(k_range+h1b-1) * int_mb(k_range+h2b-1) * int_m
     &b(k_range+h3b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsd_t_singles_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      IF (int_mb(k_spin+p4b-1) .eq. int_mb(k_spin+h1b-1)) THEN
      IF (ieor(int_mb(k_sym+p4b-1),int_mb(k_sym+h1b-1)) .eq. irrep_t) TH
     &EN
      CALL TCE_RESTRICTED_2(p4b,h1b,p4b_1,h1b_1)
      CALL TCE_RESTRICTED_4(p5b,p6b,h2b,h3b,p5b_2,p6b_2,h2b_2,h3b_2)
      dim_common = 1
      dima_sort = int_mb(k_range+p4b-1) * int_mb(k_range+h1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1) * int_mb
     &(k_range+h2b-1) * int_mb(k_range+h3b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsd_t_singles_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsd_t_singles_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h1b_1
     & - 1 + noab * (p4b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p4b-1)
     &,int_mb(k_range+h1b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsd_t_singles_1',3,MA_E
     &RR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsd_t_singles_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsd_t_singles_1',5,MA_ERR)
      if(.not.intorb) then
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h3b_2
     & - 1 + (noab+nvab) * (h2b_2 - 1 + (noab+nvab) * (p6b_2 - 1 + (noab
     &+nvab) * (p5b_2 - 1)))))
      else
      CALL GET_HASH_BLOCK_I(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),
     &(h3b_2
     & - 1 + (noab+nvab) * (h2b_2 - 1 + (noab+nvab) * (p6b_2 - 1 + (noab
     &+nvab) * (p5b_2 - 1)))),h3b_2,h2b_2,p6b_2,p5b_2)
      end if
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+h2b-1),int_mb(k_range+h3b-1)
     &,4,3,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsd_t_singles_1',6,MA_E
     &RR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsd_t_singles_1',7
     &,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsd_t_singles_1',8
     &,MA_ERR)
      END IF
      END IF
      END IF
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),6,4,3,5,2,1,1.0d0)
      END IF
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),6,4,3,2,5,1,-1.0d0)
      END IF
      IF ((t_p4b .eq. p4b) .and. (t_p5b .eq. p5b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),6,4,3,2,1,5,1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,6,3,5,2,1,-1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,6,3,2,5,1,1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p4b) .and. (t_p6b .eq. p6b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,6,3,2,1,5,-1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h1b) .and. (t_h2b .eq. h2b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,3,6,5,2,1,1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h1b) .and. (t_h3b .eq. h
     &3b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,3,6,2,5,1,-1.0d0)
      END IF
      IF ((t_p4b .eq. p5b) .and. (t_p5b .eq. p6b) .and. (t_p6b .eq. p4b)
     & .and. (t_h1b .eq. h2b) .and. (t_h2b .eq. h3b) .and. (t_h3b .eq. h
     &1b)) THEN
      CALL TCE_SORTACC_6(dbl_mb(k_c_sort),a_c,int_mb(k_range+h3b-1),
     &int_mb(k_range+h2b-1),int_mb(k_range+p6b-1),int_mb(k_range+p5b-1),
     &int_mb(k_range+h1b-1),int_mb(k_range+p4b-1),4,3,6,2,1,5,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsd_t_singles_1',9
     &,MA_ERR)
      END IF
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
