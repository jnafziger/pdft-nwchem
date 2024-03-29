      SUBROUTINE tce_mo2e_offset_intorb(l_a_offset,k_a_offset,size)
C     $Id: tce_mo2e_offset_intorb.F,v 1.2 2008-01-14 15:20:34 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     v ( g3 g4 g1 g2 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
#include "tce_main.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER g3b
      INTEGER g4b
      INTEGER g1b
      INTEGER g2b
      INTEGER IROW,ICOL,IRES
      INTEGER INDEX_PAIR
c
      length = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &    ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1))))
     &    .eq. irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN       
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
c
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('tce_mo2e_offset',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1)))) .eq. 
     &irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN
      addr = addr + 1
      IRES=INDEX_PAIR(IROW,ICOL)
      int_mb(k_a_offset+addr) = IRES
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range_alpha+g3b-1) * 
     &int_mb(k_range_alpha+g4b-1) * int_mb(k_range_alpha+g1b-1) * 
     &int_mb(k_range_alpha+g2b-1)
      END IF
c      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
c






      SUBROUTINE tce_mo2e_pairs(l_a_offset,k_a_offset,size)
C     $Id: tce_mo2e_offset_intorb.F,v 1.2 2008-01-14 15:20:34 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     v ( g3 g4 g1 g2 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
#include "tce_main.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER g3b
      INTEGER g4b
      INTEGER g1b
      INTEGER g2b
      INTEGER IROW,ICOL,IRES
      INTEGER INDEX_PAIR
      INTEGER I
      INTEGER ISPAIR
      INTEGER XOFFSET
      INTEGER IBEFORE
c
      length = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
      ISPAIR = 0 
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &    ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1))))
     &    .eq. irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN
      ISPAIR=1
      END IF
      END IF
      END IF
      END DO
      END DO
      IF(ISPAIR.EQ.1) length=length+1
      END DO
      END DO
c
c length test
      if(length.ne.((noa+nva)*(noa+nva+1))/2) 
     &  CALL ERRQUIT('tce_mo2e_pairs',0,MA_ERR)
c
c --- debug --
c       write(6,*)' qqq_1'
c       call  util_flush(6)
c ------------
      IF (.not.MA_PUSH_GET(mt_int,3*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('tce_mo2e_offset',0,MA_ERR)
c --- debug --
c       write(6,*)' qqq_2'
c       call  util_flush(6)
c ------------
      do i=1,3*length+1
       int_mb(k_a_offset+i-1)=0
      enddo  
      int_mb(k_a_offset) = length
      addr = 0
      xoffset = 0
      ibefore = 0
cc      size = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
        int_mb(k_a_offset+2*length+addr+1) = ibefore     
       size = 0
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1)))) .eq.
     &irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN
cc      addr = addr + 1
cc      IRES=INDEX_PAIR(IROW,ICOL)
cc      int_mb(k_a_offset+addr) = IRES
cc      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range_alpha+g3b-1) *
     &int_mb(k_range_alpha+g4b-1) * int_mb(k_range_alpha+g1b-1) *
     &int_mb(k_range_alpha+g2b-1)
      ibefore=ibefore+1 
      END IF
c      END IF
      END IF
      END IF
      END DO
      END DO
       if(size.ne.0) then
        addr = addr + 1
        int_mb(k_a_offset+addr)=size
        int_mb(k_a_offset+length+addr)=xoffset
        xoffset = xoffset + size
       else
        addr = addr + 1 
        int_mb(k_a_offset+addr)=0
        int_mb(k_a_offset+length+addr)=0
       end if
      END DO
      END DO
      RETURN
      END
c
      INTEGER FUNCTION INDEX_SINGLE(I)
      IMPLICIT NONE
      INTEGER I 
      INDEX_SINGLE=(I*(I-1))/2
      RETURN 
      END
c
      INTEGER FUNCTION INDEX_PAIR(I,J)
      IMPLICIT NONE
      INTEGER I,J
      INDEX_PAIR=(I*(I-1))/2+J
      RETURN
      END       
