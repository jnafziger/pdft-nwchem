      SUBROUTINE YGEHRD( N, ILO, IHI, A, LDA, TAU, WORK, LWORK, INFO )
c $Id: ygehrd.F,v 1.2 2005-11-09 02:07:17 edo Exp $
*
      implicit none
#include "y64.fh"
      INTEGER            IHI, ILO, INFO, LDA, LWORK, N
      DOUBLE PRECISION   A( LDA, * ), TAU( * ), WORK( LWORK )
c
      INTGR4    IHI4, ILO4, INFO4, LDA4, LWORK4, N4
c
      IHI4=ihi
      ILO4=ilo
      LDA4=lda
      LWORK4=lwork
      N4=n
c
      call DGEHRD( N4, ILO4, IHI4, A, LDA4, TAU, WORK, LWORK4, INFO4)
c
      info=info4
      return
      end
