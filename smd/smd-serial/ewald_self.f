c
c $Id: ewald_self.f,v 1.1 2008-04-18 17:40:30 marat Exp $
c

      SUBROUTINE ewald_self(ewald1)

      implicit none

      include 'p_array.inc'
      include 'p_const.inc'
      include 'cm_atom.inc'
      include 'cm_ewld.inc'

      integer i,iatm

      real*8 ewald1

      ewald1=0.0

      do i=1,natms

       iatm=atmtype(i)
       ewald1=ewald1+typchge(iatm)*typchge(iatm)

      enddo

      ewald1=-convfct1*alpha*ewald1/sqrpi

      return

      END
