      SUBROUTINE eomccsdtq_y1_20_8(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c
     &_offset)
C     $Id: eomccsdtq_y1_20_8.F,v 1.2 2005-12-19 19:04:07 kowalski Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h2 p15 p18 p19 h13 h14 h16 h17 )_vttt + = 1 * Sum ( p9 ) * t ( p9 p15 p19 h14 h16 h17 )_t * i2 ( h2 p18 h13 p9 )_vtt
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
      INTEGER p15b
      INTEGER p19b
      INTEGER p18b
      INTEGER h14b
      INTEGER h16b
      INTEGER h17b
      INTEGER h13b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p9b
      INTEGER p15b_1
      INTEGER p19b_1
      INTEGER p9b_1
      INTEGER h14b_1
      INTEGER h16b_1
      INTEGER h17b_1
      INTEGER h2b_2
      INTEGER p18b_2
      INTEGER h13b_2
      INTEGER p9b_2
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
      DO h2b = 1,noab
      DO p15b = noab+1,noab+nvab
      DO p19b = p15b,noab+nvab
      DO p18b = noab+1,noab+nvab
      DO h14b = 1,noab
      DO h16b = h14b,noab
      DO h17b = h16b,noab
      DO h13b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h2b-1)+int_mb(k_spin+p15b-
     &1)+int_mb(k_spin+p18b-1)+int_mb(k_spin+p19b-1)+int_mb(k_spin+h13b-
     &1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+h17b-
     &1).ne.16)) THEN
      IF (int_mb(k_spin+h2b-1)+int_mb(k_spin+p15b-1)+int_mb(k_spin+p18b-
     &1)+int_mb(k_spin+p19b-1) .eq. int_mb(k_spin+h13b-1)+int_mb(k_spin+
     &h14b-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+h17b-1)) THEN
      IF (ieor(int_mb(k_sym+h2b-1),ieor(int_mb(k_sym+p15b-1),ieor(int_mb
     &(k_sym+p18b-1),ieor(int_mb(k_sym+p19b-1),ieor(int_mb(k_sym+h13b-1)
     &,ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+h16b-1),int_mb(k_sym+
     &h17b-1)))))))) .eq. ieor(irrep_v,ieor(irrep_t,ieor(irrep_t,irrep_t
     &)))) THEN
      dimc = int_mb(k_range+h2b-1) * int_mb(k_range+p15b-1) * int_mb(k_r
     &ange+p18b-1) * int_mb(k_range+p19b-1) * int_mb(k_range+h13b-1) * i
     &nt_mb(k_range+h14b-1) * int_mb(k_range+h16b-1) * int_mb(k_range+h1
     &7b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_20_8',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p9b = noab+1,noab+nvab
      IF (int_mb(k_spin+p15b-1)+int_mb(k_spin+p19b-1)+int_mb(k_spin+p9b-
     &1) .eq. int_mb(k_spin+h14b-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+
     &h17b-1)) THEN
      IF (ieor(int_mb(k_sym+p15b-1),ieor(int_mb(k_sym+p19b-1),ieor(int_m
     &b(k_sym+p9b-1),ieor(int_mb(k_sym+h14b-1),ieor(int_mb(k_sym+h16b-1)
     &,int_mb(k_sym+h17b-1)))))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_6(p15b,p19b,p9b,h14b,h16b,h17b,p15b_1,p19b_1,p
     &9b_1,h14b_1,h16b_1,h17b_1)
      CALL TCE_RESTRICTED_4(h2b,p18b,h13b,p9b,h2b_2,p18b_2,h13b_2,p9b_2)
      dim_common = int_mb(k_range+p9b-1)
      dima_sort = int_mb(k_range+p15b-1) * int_mb(k_range+p19b-1) * int_
     &mb(k_range+h14b-1) * int_mb(k_range+h16b-1) * int_mb(k_range+h17b-
     &1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h2b-1) * int_mb(k_range+p18b-1) * int_m
     &b(k_range+h13b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_20_8',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsdtq_y1_20_8',2,MA_ERR)
      IF ((p9b .le. p15b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h17b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (p19b_1 -
     & noab - 1 + nvab * (p15b_1 - noab - 1 + nvab * (p9b_1 - noab - 1))
     &)))))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p9b-1)
     &,int_mb(k_range+p15b-1),int_mb(k_range+p19b-1),int_mb(k_range+h14b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h17b-1),6,5,4,3,2,1,1.0d
     &0)
      END IF
      IF ((p15b .lt. p9b) .and. (p9b .le. p19b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h17b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (p19b_1 -
     & noab - 1 + nvab * (p9b_1 - noab - 1 + nvab * (p15b_1 - noab - 1))
     &)))))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p9b-1),int_mb(k_range+p19b-1),int_mb(k_range+h14b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h17b-1),6,5,4,3,1,2,-1.0
     &d0)
      END IF
      IF ((p19b .lt. p9b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h17b_
     &1 - 1 + noab * (h16b_1 - 1 + noab * (h14b_1 - 1 + noab * (p9b_1 - 
     &noab - 1 + nvab * (p19b_1 - noab - 1 + nvab * (p15b_1 - noab - 1))
     &)))))
      CALL TCE_SORT_6(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p15b-1
     &),int_mb(k_range+p19b-1),int_mb(k_range+p9b-1),int_mb(k_range+h14b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h17b-1),6,5,4,2,1,3,1.0d
     &0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsdtq_y1_20_8',3,MA_
     &ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsdtq_y1_20_8',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsdtq_y1_20_8',5,MA_ERR)
      IF ((h13b .le. p9b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p9b_2
     & - noab - 1 + nvab * (h13b_2 - 1 + noab * (p18b_2 - noab - 1 + nva
     &b * (h2b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h2b-1)
     &,int_mb(k_range+p18b-1),int_mb(k_range+h13b-1),int_mb(k_range+p9b-
     &1),3,2,1,4,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsdtq_y1_20_8',6,MA_
     &ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsdtq_y1_20_8',
     &7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsdtq_y1_20_8',
     &8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsdtq_y1_20_8',9,MA_ERR)
      IF ((p15b .le. p18b) .and. (p18b .le. p19b) .and. (h13b .le. h14b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,2,7,1,6,5,4,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h14b - 1 + noab * (h13b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p18b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p15b .le. p18b) .and. (p18b .le. p19b) .and. (h14b .le. h13b)
     & .and. (h13b .le. h16b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,2,7,6,1,5,4,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h13b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p18b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p15b .le. p18b) .and. (p18b .le. p19b) .and. (h16b .le. h13b)
     & .and. (h13b .le. h17b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,2,7,6,5,1,4,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h13b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p18b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p15b .le. p18b) .and. (p18b .le. p19b) .and. (h17b .le. h13b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,2,7,6,5,4,1,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h13b 
     &- 1 + noab * (h17b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p18b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p18b .le. p15b) .and. (h13b .le. h14b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,2,8,7,1,6,5,4,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h14b - 1 + noab * (h13b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p15b - noab - 1 + nvab * (p18b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p18b .le. p15b) .and. (h14b .le. h13b) .and. (h13b .le. h16b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,2,8,7,6,1,5,4,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h13b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p15b - noab - 1 + nvab * (p18b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p18b .le. p15b) .and. (h16b .le. h13b) .and. (h13b .le. h17b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,2,8,7,6,5,1,4,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h13b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p15b - noab - 1 + nvab * (p18b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p18b .le. p15b) .and. (h17b .le. h13b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,2,8,7,6,5,4,1,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h13b 
     &- 1 + noab * (h17b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p19b - noab - 1 + nvab * (p15b - noab - 1 + nvab * (p18b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p19b .le. p18b) .and. (h13b .le. h14b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,7,2,1,6,5,4,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h14b - 1 + noab * (h13b - 1 + noa
     &b * (p18b - noab - 1 + nvab * (p19b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p19b .le. p18b) .and. (h14b .le. h13b) .and. (h13b .le. h16b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,7,2,6,1,5,4,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h16b - 1 + noab * (h13b - 1 + noab * (h14b - 1 + noa
     &b * (p18b - noab - 1 + nvab * (p19b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p19b .le. p18b) .and. (h16b .le. h13b) .and. (h13b .le. h17b)
     &) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,7,2,6,5,1,4,-1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h17b 
     &- 1 + noab * (h13b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p18b - noab - 1 + nvab * (p19b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF ((p19b .le. p18b) .and. (h17b .le. h13b)) THEN
      CALL TCE_SORT_8(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h13b-1
     &),int_mb(k_range+p18b-1),int_mb(k_range+h2b-1),int_mb(k_range+h17b
     &-1),int_mb(k_range+h16b-1),int_mb(k_range+h14b-1),int_mb(k_range+p
     &19b-1),int_mb(k_range+p15b-1),3,8,7,2,6,5,4,1,1.0d0/12.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h13b 
     &- 1 + noab * (h17b - 1 + noab * (h16b - 1 + noab * (h14b - 1 + noa
     &b * (p18b - noab - 1 + nvab * (p19b - noab - 1 + nvab * (p15b - no
     &ab - 1 + nvab * (h2b - 1)))))))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsdtq_y1_20_8',10,MA
     &_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsdtq_y1_20_8',
     &11,MA_ERR)
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
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
