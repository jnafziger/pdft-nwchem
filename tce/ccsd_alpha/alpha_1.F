      SUBROUTINE alpha_1(d_d1,d_i0,d_t1,d_t2,d_tr1,d_tr2,d_y1,d_y2,k_d1_
     &offset,k_i0_offset,k_t1_offset,k_t2_offset,k_tr1_offset,k_tr2_offs
     &et,k_y1_offset,k_y2_offset)
C     $Id: alpha_1.F,v 1.1 2007-10-29 17:37:17 jhammond Exp $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( )_trd + = 1 * Sum ( p2 h1 ) * d ( h1 p2 )_d * i1 ( p2 h1 )_tr
C         i1 ( p2 h1 )_tr + = 1 * tr ( p2 h1 )_tr
C         i1 ( p2 h1 )_ytr + = 1 * Sum ( h4 p3 ) * tr ( p2 p3 h1 h4 )_tr * y ( h4 p3 )_y
C         i1 ( p2 h1 )_ytrt + = -1 * Sum ( h3 ) * t ( p2 h3 )_t * i2 ( h3 h1 )_ytr
C             i2 ( h3 h1 )_ytr + = 1 * Sum ( p4 ) * tr ( p4 h1 )_tr * y ( h3 p4 )_y
C             i2 ( h3 h1 )_ytr + = 1/2 * Sum ( h6 p4 p5 ) * tr ( p4 p5 h1 h6 )_tr * y ( h3 h6 p4 p5 )_y
C         i1 ( p2 h1 )_yttr + = -1 * Sum ( h7 ) * tr ( p2 h7 )_tr * i2 ( h7 h1 )_yt
C             i2 ( h7 h1 )_yt + = 1 * Sum ( p3 ) * t ( p3 h1 )_t * y ( h7 p3 )_y
C             i2 ( h7 h1 )_yt + = -1/2 * Sum ( h5 p3 p4 ) * t ( p3 p4 h1 h5 )_t * y ( h5 h7 p3 p4 )_y
C         i1 ( p2 h1 )_yttr + = 1/2 * Sum ( h5 h6 p4 ) * tr ( p2 p4 h5 h6 )_tr * i2 ( h5 h6 h1 p4 )_yt
C             i2 ( h5 h6 h1 p4 )_yt + = -1 * Sum ( p3 ) * t ( p3 h1 )_t * y ( h5 h6 p3 p4 )_y
C         i1 ( p2 h1 )_ytrt + = -1/2 * Sum ( h4 h5 p3 ) * t ( p2 p3 h4 h5 )_t * i2 ( h4 h5 h1 p3 )_ytr
C             i2 ( h4 h5 h1 p3 )_ytr + = -1 * Sum ( p6 ) * tr ( p6 h1 )_tr * y ( h4 h5 p3 p6 )_y
C     i0 ( )_ytrd + = -1 * Sum ( h2 h1 ) * d ( h1 h2 )_d * i1 ( h2 h1 )_ytr
C         i1 ( h2 h1 )_ytr + = 1 * Sum ( p3 ) * tr ( p3 h1 )_tr * y ( h2 p3 )_y
C         i1 ( h2 h1 )_ytr + = 1/2 * Sum ( h5 p3 p4 ) * tr ( p3 p4 h1 h5 )_tr * y ( h2 h5 p3 p4 )_y
C     i0 ( )_dtry + = 1 * Sum ( p1 h3 ) * y ( h3 p1 )_y * i1 ( p1 h3 )_dtr
C         i1 ( p1 h3 )_dtr + = 1 * Sum ( p2 ) * d ( p1 p2 )_d * tr ( p2 h3 )_tr
C     i0 ( )_ytrd + = 1/2 * Sum ( p2 p1 ) * d ( p1 p2 )_d * i1 ( p2 p1 )_ytr
C         i1 ( p2 p1 )_ytr + = 1 * Sum ( h4 h5 p3 ) * tr ( p2 p3 h4 h5 )_tr * y ( h4 h5 p1 p3 )_y
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_i0
      INTEGER k_i0_offset
      INTEGER d_d1
      INTEGER k_d1_offset
      INTEGER d_i1
      INTEGER k_i1_offset
      INTEGER d_y1
      INTEGER k_y1_offset
      INTEGER l_i1_offset
      INTEGER d_tr1
      INTEGER k_tr1_offset
      INTEGER size_i1
      INTEGER d_tr2
      INTEGER k_tr2_offset
      INTEGER d_t1
      INTEGER k_t1_offset
      INTEGER d_i2
      INTEGER k_i2_offset
      INTEGER d_t2
      INTEGER k_t2_offset
      INTEGER l_i2_offset
      INTEGER size_i2
      INTEGER d_y2
      INTEGER k_y2_offset
      CHARACTER*255 filename
      CALL OFFSET_alpha_1_1_1(l_i1_offset,k_i1_offset,size_i1)
      CALL TCE_FILENAME('alpha_1_1_1_i1',filename)
      CALL CREATEFILE(filename,d_i1,size_i1)
      CALL alpha_1_1_1(d_tr1,k_tr1_offset,d_i1,k_i1_offset)
      CALL alpha_1_1_2(d_tr2,k_tr2_offset,d_y1,k_y1_offset,d_i1,k_i1_off
     &set)
      CALL OFFSET_alpha_1_1_3_1(l_i2_offset,k_i2_offset,size_i2)
      CALL TCE_FILENAME('alpha_1_1_3_1_i2',filename)
      CALL CREATEFILE(filename,d_i2,size_i2)
      CALL alpha_1_1_3_1(d_tr1,k_tr1_offset,d_y1,k_y1_offset,d_i2,k_i2_o
     &ffset)
      CALL alpha_1_1_3_2(d_tr2,k_tr2_offset,d_y2,k_y2_offset,d_i2,k_i2_o
     &ffset)
      CALL RECONCILEFILE(d_i2,size_i2)
      CALL alpha_1_1_3(d_t1,k_t1_offset,d_i2,k_i2_offset,d_i1,k_i1_offse
     &t)
      CALL DELETEFILE(d_i2)
      IF (.not.MA_POP_STACK(l_i2_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_1_4_1(l_i2_offset,k_i2_offset,size_i2)
      CALL TCE_FILENAME('alpha_1_1_4_1_i2',filename)
      CALL CREATEFILE(filename,d_i2,size_i2)
      CALL alpha_1_1_4_1(d_t1,k_t1_offset,d_y1,k_y1_offset,d_i2,k_i2_off
     &set)
      CALL alpha_1_1_4_2(d_t2,k_t2_offset,d_y2,k_y2_offset,d_i2,k_i2_off
     &set)
      CALL RECONCILEFILE(d_i2,size_i2)
      CALL alpha_1_1_4(d_tr1,k_tr1_offset,d_i2,k_i2_offset,d_i1,k_i1_off
     &set)
      CALL DELETEFILE(d_i2)
      IF (.not.MA_POP_STACK(l_i2_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_1_5_1(l_i2_offset,k_i2_offset,size_i2)
      CALL TCE_FILENAME('alpha_1_1_5_1_i2',filename)
      CALL CREATEFILE(filename,d_i2,size_i2)
      CALL alpha_1_1_5_1(d_t1,k_t1_offset,d_y2,k_y2_offset,d_i2,k_i2_off
     &set)
      CALL RECONCILEFILE(d_i2,size_i2)
      CALL alpha_1_1_5(d_tr2,k_tr2_offset,d_i2,k_i2_offset,d_i1,k_i1_off
     &set)
      CALL DELETEFILE(d_i2)
      IF (.not.MA_POP_STACK(l_i2_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_1_6_1(l_i2_offset,k_i2_offset,size_i2)
      CALL TCE_FILENAME('alpha_1_1_6_1_i2',filename)
      CALL CREATEFILE(filename,d_i2,size_i2)
      CALL alpha_1_1_6_1(d_tr1,k_tr1_offset,d_y2,k_y2_offset,d_i2,k_i2_o
     &ffset)
      CALL RECONCILEFILE(d_i2,size_i2)
      CALL alpha_1_1_6(d_t2,k_t2_offset,d_i2,k_i2_offset,d_i1,k_i1_offse
     &t)
      CALL DELETEFILE(d_i2)
      IF (.not.MA_POP_STACK(l_i2_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL RECONCILEFILE(d_i1,size_i1)
      CALL alpha_1_1(d_d1,k_d1_offset,d_i1,k_i1_offset,d_i0,k_i0_offset)
      CALL DELETEFILE(d_i1)
      IF (.not.MA_POP_STACK(l_i1_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_2_1(l_i1_offset,k_i1_offset,size_i1)
      CALL TCE_FILENAME('alpha_1_2_1_i1',filename)
      CALL CREATEFILE(filename,d_i1,size_i1)
      CALL alpha_1_2_1(d_tr1,k_tr1_offset,d_y1,k_y1_offset,d_i1,k_i1_off
     &set)
      CALL alpha_1_2_2(d_tr2,k_tr2_offset,d_y2,k_y2_offset,d_i1,k_i1_off
     &set)
      CALL RECONCILEFILE(d_i1,size_i1)
      CALL alpha_1_2(d_d1,k_d1_offset,d_i1,k_i1_offset,d_i0,k_i0_offset)
      CALL DELETEFILE(d_i1)
      IF (.not.MA_POP_STACK(l_i1_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_3_1(l_i1_offset,k_i1_offset,size_i1)
      CALL TCE_FILENAME('alpha_1_3_1_i1',filename)
      CALL CREATEFILE(filename,d_i1,size_i1)
      CALL alpha_1_3_1(d_d1,k_d1_offset,d_tr1,k_tr1_offset,d_i1,k_i1_off
     &set)
      CALL RECONCILEFILE(d_i1,size_i1)
      CALL alpha_1_3(d_y1,k_y1_offset,d_i1,k_i1_offset,d_i0,k_i0_offset)
      CALL DELETEFILE(d_i1)
      IF (.not.MA_POP_STACK(l_i1_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      CALL OFFSET_alpha_1_4_1(l_i1_offset,k_i1_offset,size_i1)
      CALL TCE_FILENAME('alpha_1_4_1_i1',filename)
      CALL CREATEFILE(filename,d_i1,size_i1)
      CALL alpha_1_4_1(d_tr2,k_tr2_offset,d_y2,k_y2_offset,d_i1,k_i1_off
     &set)
      CALL RECONCILEFILE(d_i1,size_i1)
      CALL alpha_1_4(d_d1,k_d1_offset,d_i1,k_i1_offset,d_i0,k_i0_offset)
      CALL DELETEFILE(d_i1)
      IF (.not.MA_POP_STACK(l_i1_offset)) CALL ERRQUIT('alpha_1',-1,MA_E
     &RR)
      RETURN
      END
