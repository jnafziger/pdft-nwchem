      subroutine ifill(n,val,a,ia)
C$Id: ifill.f,v 1.4 1995-02-02 18:09:39 d3g681 Exp $
      implicit none
      integer n, val, a(*), ia, i
c
c     initialise integer precision array to scalar value
c
      if (ia.eq.1) then
         do 10 i = 1, n
            a(i) = val
 10      continue
      else
         do 20 i = 1,(n-1)*ia+1,ia
            a(i) = val
 20      continue
      endif
c
      end
