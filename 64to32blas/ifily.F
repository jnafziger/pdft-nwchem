      subroutine ifily(n,val,a,ia)
C$Id: ifily.F,v 1.1 2005-11-09 21:39:31 edo Exp $
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
