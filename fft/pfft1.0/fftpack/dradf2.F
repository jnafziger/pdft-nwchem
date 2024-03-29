C****************************************************************
C   Translated by Pacific-Sierra Research VAST-2          
C   Version 6.1C1 on 12/ 8/97 at 23:36:36
C****************************************************************
C
      subroutine dradf2 (ido,l1,cc,ch,wa1)
*      
* $Id: dradf2.F,v 1.3 1997-12-10 01:21:05 d3g270 Exp $
*      
*      
* $Id: dradf2.F,v 1.3 1997-12-10 01:21:05 d3g270 Exp $
*      
      double precision cc(ido,l1,2), ch(ido,2,l1), wa1(1), ti2, tr2
c      
      do 101 k=1,l1
         ch(1,1,k) = cc(1,k,1)+cc(1,k,2)
         ch(ido,2,k) = cc(1,k,1)-cc(1,k,2)
  101 continue
c      
      if (ido - 2 .lt. 0) go to 107
      if (ido - 2 .eq. 0) go to 105
  102 continue
      idp2 = ido + 2
      do 104 k=1,l1
      do i = 1, ((ido - 1)/2)
         tr2 = wa1(i*2-1)*cc(i*2,k,2) + wa1(i*2)*cc(1+i*2,k,2)
         ti2 = wa1(i*2-1)*cc(1+i*2,k,2) - wa1(i*2)*cc(i*2,k,2)
         ch(1+i*2,1,k) = cc(1+i*2,k,1) + ti2
         ch(idp2-1-i*2,2,k) = ti2 - cc(1+i*2,k,1)
         ch(i*2,1,k) = cc(i*2,k,1) + tr2
         ch(idp2-(i+1)*2,2,k) = cc(i*2,k,1) - tr2
      end do
  104 continue
c      
      if (mod(ido,2) .eq. 1) return
  105 do 106 k=1,l1
         ch(1,2,k) = -cc(ido,k,2)
         ch(ido,1,k) = cc(ido,k,1)
  106 continue
c      
  107 return
      end
