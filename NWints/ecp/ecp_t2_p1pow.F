C $Id: ecp_t2_p1pow.F,v 1.7 2003-02-12 20:18:33 bert Exp $  
************************************************************************
*                                                                      *
      subroutine ecp_t2_p1pow (n,m,k,alpha,beta,gamma,term,test,temp,
     &    Q,tol)
*                                                                      *
*   Calculate Q^{|k|+1}_{m+km} functions for k = 1,0,-1, by single     *
*   power series expansion of bessel function in radial integral.      *
*                                                                      *
*   Argument (status) - description                                    *
*                                                                      *
*   n (inp) - number of Q functions to be evaluated for given          *
*             order                                                    *
*   m (inp) - order of Q function                                      *
*   k (inp) - rank of Q function                                       *
*   alpha (inp) - array of values a/2sqrt(c)                           *
*   beta (inp) - array of values b/2sqrt(c)                            *
*   gamma - array of values 1/sqrt(c)                                  *
*   term (scr) - array of terms alpha^j/(2j)!!(2m+2j+1)!!              *
*   test (scr) - array of ratios of terms to sums                      *
*   temp (scr) - work array, used for Q_m^{m+2j} recursion             *
*   Q (out) - Q functions                                              *
*   tol (inp) - maximum relative error in Q functions                  *
*                                                                      *
*   Written by K. G. Dyall                                             *
*                                                                      *
************************************************************************
      implicit none
#include "ecp_consts.fh"
      integer i,idamax,j1,j2,j3,k,k_abs,m,n
      double precision alpha(n),beta(n),gamma(n),term(n),test(n),Q(n),
     &    temp(n,9),tol,fac0,fac1,fac2,fac3,fac4,fac5,fac0i,fac1i,fac2i
      double precision vbig,renorm,eps
      parameter (vbig=30.0,eps=1.d-50)
*
*   Set up factors for recursion
*
      if (n .eq. 0) return
      fac1 = m+1+min(k,0)
      fac1 = fac1+half
      fac2 = 1-max(k,0)
      fac3 = half
      fac4 = m+1
      fac5 = fac4+one+half
C      write (6,'(5F10.4)') fac1,fac2,fac3,fac4,fac5
*
*   First term for k < 1 is Q^m+1_m; this is needed for the recursion
*   in any case. Generate Q^m+3_m by recursion from Q^m+1_m, Q^m+2_m+1
*
      do i = 1,n
        Q(i) = one
      end do
      call ecp_t1_Q1int (n,m,beta,Q,temp,temp(1,3),temp(1,9),tol)
      call ecp_t1_Q1int (n,m+1,beta,Q,temp(1,2),temp(1,3),temp(1,9),tol)
      fac1i = one/fac1
      do i = 1,n
        temp(i,2) = beta(i)*temp(i,2) + fac4*temp(i,1)
        Q(i) = fac2*temp(i,1)
        temp(i,4) = alpha(i)**2
        temp(i,5) = beta(i)**2
        if (k .eq. 1) then
          term(i) = one
        else
          term(i) = fac1i*temp(i,4)
        end if
        test(i) = one
	temp(i,9) = -alpha(i)*(beta(i)+beta(i)+alpha(i))
      end do
      j1 = 0
C      write (6,'(5F10.4)') fac1,fac2,fac3,fac4,fac5
    1 i = idamax(n,test,1)
      if (test(i) .ge .tol) then
        j1 = mod(j1,3)+1
        j2 = mod(j1,3)+1
        j3 = mod(j2,3)+1
        fac0 = max(fac2,one)
        fac1 = fac1+one
        fac2 = fac2+one
        fac0i = one/fac0
        fac1i = one/fac1
        fac2i = one/fac2
        do i = 1,n
          if (test(i) .gt. tol) then
c      write(6,*) 'B',temp(i,1),temp(i,2),temp(i,3),term(i)
            renorm = 0.0d0
               if (abs(temp(i,1)).lt.eps) then
                  temp(i,1) = 0.0d0
               elseif (abs(log10(abs(temp(i,1)))).gt.renorm) then
                  renorm = abs(log10(abs(temp(i,1))))
               endif
               if (abs(temp(i,2)).lt.eps) then
                  temp(i,2) = 0.0d0
               elseif (abs(log10(abs(temp(i,2)))).gt.renorm) then
                  renorm = abs(log10(abs(temp(i,2))))
               endif
               if (abs(temp(i,3)).lt.eps) then
                  temp(i,3) = 0.0d0
               elseif (abs(log10(abs(temp(i,3)))).gt.renorm) then
                  renorm = abs(log10(abs(temp(i,3))))
               endif
            if (renorm.gt.vbig) then
               temp(i,1) = temp(i,1) / 10.0d0**(int(renorm))
               temp(i,2) = temp(i,2) / 10.0d0**(int(renorm))
               temp(i,3) = temp(i,3) / 10.0d0**(int(renorm))
               term(i) = term(i) * 10.0d0**(int(renorm))
            endif
c       write(6,*) 'B',temp(i,1),temp(i,2),temp(i,3),temp(i,4),temp(i,5)
c       write(6,*) 'B',(fac5+temp(i,5))*temp(i,j2),
c    &              fac3*fac4*fac0i*temp(i,j1)
c       write(6,*) 'B',fac3,fac4,fac0i,temp(i,j1)
c       write(6,*) 'B',fac1i,term(i),temp(i,4)
            Q(i) = Q(i)+temp(i,j2)*term(i)
            temp(i,j3) = ((fac5+temp(i,5))*temp(i,j2)
     &                 - fac3*fac4*fac0i*temp(i,j1))*fac2i
            term(i) = term(i)*temp(i,4)*fac1i
c       write(6,*) 'B',term(i),temp(i,j3),Q(i)
c       write(6,*)
            test(i) = (term(i)*temp(i,j3))/Q(i)
          end if
        end do
        fac3 = fac3+one
        fac4 = fac4+one
        fac5 = fac5+two
        go to 1
      end if
      i = fac3+one
C      write (6,*) ' Terms in single power series: ',i
C      write (6,*) 'beta,Q^0_mm values'
C      write (6,'(1p2e20.10)') (beta(i),Q(i),i=1,n)
*
*   Prefactor is (2*alpha)^{m-|k|}/(2(m-|k|)+1)!! /sqrt(c)^(m+|k|)
*
      k_abs = abs(k)
      fac1 = half
      fac5 = one
      do i = 1,m+k
        fac1 = fac1+one
        fac5 = fac5/fac1
      end do
C      write (6,*) fac1,fac5
      do i = 1,n
        Q(i) = Q(i)*alpha(i)**(m+k)*fac5*(gamma(i)**(k_abs+2))
      end do
*
*   Perform remaining exponent shift.
*
      do i = 1,n
        Q(i) = Q(i)*exp(temp(i,9))
      end do
*
      return
      end
