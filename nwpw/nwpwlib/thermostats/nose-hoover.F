*
* $Id: nose-hoover.F,v 1.9 2008-11-03 06:06:16 bylaska Exp $
*

*     ***************************
*     *				*
*     *	     Nose_Init          *
*     *				*
*     ***************************

      subroutine Nose_Init(nemax,eke0)
      implicit none
      integer nemax
      real*8 eke0


#include "mafdecls.fh"
#include "rtdb.fh"
#include "errquit.fh"
#include "nose-hoover.fh"


*     **** boltzman constant ****
      double precision kb
      parameter (kb=3.16679d-6)


*     **** local variables ****
      logical value,nosers
      integer i,rtdb,n,m
      real*8 pi,am,fmass,tmpe
      real*8 Te,Pe_tmp,betae
      real*8 Tr,Pr_tmp

*     **** external functions ****
      real*8   control_fake_mass
      real*8   control_Nose_Pe
      real*8   control_Nose_Te
      real*8   control_Nose_Pr
      real*8   control_Nose_Tr
      real*8   ion_amass
      integer  ion_nion,control_rtdb
      
      external control_fake_mass
      external control_Nose_Pe
      external control_Nose_Te
      external control_Nose_Pr
      external control_Nose_Tr
      external ion_amass
      external ion_nion,control_rtdb
     

*     ************************************
*     **** initialize the thermostats ****
*     ************************************
      Te     = control_Nose_Te()
      Tr     = control_Nose_Tr()
      Pe_tmp = control_Nose_Pe()
      Pr_tmp = control_Nose_Pr()

      rtdb   = control_rtdb()
      if (.not.rtdb_get(rtdb,'cpmd:nose_restart',mt_log,1,nosers)) 
     >   nosers = .true.

      if (.not.rtdb_get(rtdb,'cpmd:Mchain',mt_int,1,Mchain)) Mchain = 1
      if (.not.rtdb_get(rtdb,'cpmd:Nchain',mt_int,1,Nchain)) Nchain = 1
      if (.not.rtdb_get(rtdb,'cpmd:Ne_chain',mt_dbl,1,Ne_chain)) 
     >   Ne_chain = 3.0d0*nemax
      if ( (.not.rtdb_get(rtdb,'cpmd:eke0',mt_dbl,1,eke0_init))
     >      .or.(.not.nosers))
     >   eke0_init = eke0

      fmass  = control_fake_mass()

      value =           MA_alloc_get(mt_dbl,Mchain,'Xem',Xem(2),Xem(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Xe0',Xe0(2),Xe0(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Xe1',Xe1(2),Xe1(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Xe2',Xe2(2),Xe2(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Ee0',Ee0(2),Ee0(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Qe',Qe(2),Qe(1))
      value = value.and.MA_alloc_get(mt_dbl,Mchain,'Pe',Pe(2),Pe(1))

      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Xrm',Xrm(2),Xrm(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Xr0',Xr0(2),Xr0(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Xr1',Xr1(2),Xr1(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Xr2',Xr2(2),Xr2(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Er0',Er0(2),Er0(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Qr',Qr(2),Qr(1))
      value = value.and.MA_alloc_get(mt_dbl,Nchain,'Pr',Pr(2),Pr(1))
      if (.not.value) 
     >  call errquit("Nose_Init: out of heap memory",0,MA_ERR)

*     **** restart using Newton Step ??? ****
c      call dcopy(Mchain,0.0d0,0,dbl_mb(Xem(1)),1)
c      call dcopy(Mchain,0.0d0,0,dbl_mb(Xe0(1)),1)
c      call dcopy(Mchain,0.0d0,0,dbl_mb(Xe1(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xe1',mt_dbl,Mchain,dbl_mb(Xe1(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Mchain,0.0d0,0,dbl_mb(Xe1(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xe0',mt_dbl,Mchain,dbl_mb(Xe0(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Mchain,0.0d0,0,dbl_mb(Xe0(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xem',mt_dbl,Mchain,dbl_mb(Xem(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Mchain,0.0d0,0,dbl_mb(Xem(1)),1)

      call dcopy(Mchain,0.0d0,0,dbl_mb(Xe2(1)),1)
      call dcopy(Mchain,Pe_tmp,0,dbl_mb(Pe(1)),1)


c      call dcopy(Nchain,0.0d0,0,dbl_mb(Xrm(1)),1)
c      call dcopy(Nchain,0.0d0,0,dbl_mb(Xr0(1)),1)
c      call dcopy(Nchain,0.0d0,0,dbl_mb(Xr1(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xr1',mt_dbl,Nchain,dbl_mb(Xr1(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Nchain,0.0d0,0,dbl_mb(Xr1(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xr0',mt_dbl,Nchain,dbl_mb(Xr0(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Nchain,0.0d0,0,dbl_mb(Xr0(1)),1)
      if ((.not.rtdb_get(rtdb,'cpmd:Xrm',mt_dbl,Nchain,dbl_mb(Xrm(1)))) 
     >      .or.(.not.nosers))
     >  call dcopy(Nchain,0.0d0,0,dbl_mb(Xrm(1)),1)

      call dcopy(Nchain,0.0d0,0,dbl_mb(Xr2(1)),1)
      call dcopy(Nchain,Pr_tmp,0,dbl_mb(Pr(1)),1)



c      Xe0 = 0.0d0
c      Xe1 = 0.0d0
c      Xe2 = 0.0d0
c      Xr0 = 0.0d0
c      Xr1 = 0.0d0
c      Xr2 = 0.0d0
 

*     **** Set Er0(1) = (1/2)*(g*k*T), where g=number of degrees of freedom ****
      if (ion_nion().gt.2) then
c        Er0 = 0.5d0*(3.0d0*dble(ion_nion())-6.0d0)*kb*Tr
        dbl_mb(Er0(1)) = 0.5d0*(3.0d0*dble(ion_nion())-6.0d0)*kb*Tr

*     **** Dimer molecule. note that the above formula may not work for ****
*     **** linear molecules with more than two atoms.                   ****
      else
c        Er0 = 0.5d0*(1)*kb*Tr
        dbl_mb(Er0(1)) = 0.5d0*(1)*kb*Tr
      end if

*     **** Set Er0(2:Nchain) = 1/2*(k*T) ****
      if (Nchain.gt.1) then
        call dcopy(Nchain-1,0.5d0*kb*Tr,0,dbl_mb(Er0(1)+1),1)
      end if


*     *** total mass ***
      am = 0.0d0
      do i=1,ion_nion()
         am = am + ion_amass(i)
      end do


*     **** Set Ee0(1) - read from rtdb otherwise use current KE ****
      dbl_mb(Ee0(1)) = 4.0d0*kb*Te*fmass*dble(ion_nion())/am * eke0_init

*     **** Set Ee0(2:Mchain) = 1/2*(1/betae), where 1/betae = 2*Ee/Ne ****
      if (Mchain.gt.1) then
        betae = dbl_mb(Ee0(1))/Ne_chain
        call dcopy(Mchain-1,betae,0,dbl_mb(Ee0(1)+1),1)
      end if


*     **** Set Qe and Qr - read from rtdb otherwise set using periods ****
      pi = 4.0d0*datan(1.0d0)
      value = rtdb_get(rtdb,'cpmd:Qe',mt_dbl,Mchain,dbl_mb(Qe(1)))
     >   .and.rtdb_get(rtdb,'cpmd:Qr',mt_dbl,Nchain,dbl_mb(Qr(1)))
      
      if ((.not.value).or.(.not.nosers)) then
        do m=1,Mchain
         dbl_mb(Qe(1)+m-1)=dbl_mb(Ee0(1)+m-1)*(dbl_mb(Pe(1)+m-1)/pi)**2
        end do
        do n=1,Nchain
         dbl_mb(Qr(1)+n-1)=dbl_mb(Er0(1)+n-1)*(dbl_mb(Pr(1)+n-1)/pi)**2
        end do
      else
        do m=1,Mchain
          dbl_mb(Pe(1)+m-1)
     >    = pi*dsqrt(dbl_mb(Qe(1)+m-1)/dbl_mb(Ee0(1)+m-1))
        end do
        do n=1,Nchain
          dbl_mb(Pr(1)+N-1)
     >    = pi*dsqrt(dbl_mb(Qr(1)+n-1)/dbl_mb(Er0(1)+n-1))
        end do
      end if

      return
      end


*     ***************************
*     *                         *
*     *      Nose_end           *
*     *                         *
*     ***************************

      subroutine Nose_end()
      implicit none

#include "mafdecls.fh"
#include "rtdb.fh"
#include "errquit.fh"
#include "nose-hoover.fh"


      !**** local variables ****
      logical value
      integer rtdb,m,n
      real*8  dt

      !**** external functions ****
      integer  control_rtdb
      real*8   control_time_step
      external control_rtdb
      external control_time_step

*     **** put velecities in Xem and Xrm ****
      dt = control_time_step()
      do m=1,Mchain
        dbl_mb(Xem(1)+m-1) = (dbl_mb(Xe2(1)+m-1)-dbl_mb(Xe0(1)+m-1))
     >                      /(2.0d0*dt)
      end do
      do n=1,Nchain
        dbl_mb(Xrm(1)+n-1) = (dbl_mb(Xr2(1)+n-1)-dbl_mb(Xr0(1)+n-1))
     >                      /(2.0d0*dt)
      end do

*     **** save restart information to rtdb ****
      rtdb  = control_rtdb()
      value = rtdb_put(rtdb,'cpmd:eke0',mt_dbl,1,eke0_init)
     >   .and.rtdb_put(rtdb,'cpmd:Mchain',mt_int,1,Mchain) 
     >   .and.rtdb_put(rtdb,'cpmd:Nchain',mt_int,1,Nchain) 
     >   .and.rtdb_put(rtdb,'cpmd:Ne_chain',mt_dbl,1,Ne_chain) 
     >   .and.rtdb_put(rtdb,'cpmd:Qe', mt_dbl,Mchain,dbl_mb(Qe(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xe1',mt_dbl,Mchain,dbl_mb(Xe1(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xe0',mt_dbl,Mchain,dbl_mb(Xe0(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xem',mt_dbl,Mchain,dbl_mb(Xem(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Qr', mt_dbl,Nchain,dbl_mb(Qr(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xr1',mt_dbl,Nchain,dbl_mb(Xr1(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xr0',mt_dbl,Nchain,dbl_mb(Xr0(1)))
     >   .and.rtdb_put(rtdb,'cpmd:Xrm',mt_dbl,Nchain,dbl_mb(Xrm(1)))
      if (.not.value)
     >  call errquit(
     >       'Nose_End: error writing to rtdb', 0, RTDB_ERR)


      value = value.and.MA_free_heap(Xem(2))
      value = value.and.MA_free_heap(Xe0(2))
      value = value.and.MA_free_heap(Xe1(2))
      value = value.and.MA_free_heap(Xe2(2))
      value = value.and.MA_free_heap(Ee0(2))
      value = value.and.MA_free_heap(Qe(2))
      value = value.and.MA_free_heap(Pe(2))

      value = value.and.MA_free_heap(Xrm(2))
      value = value.and.MA_free_heap(Xr0(2))
      value = value.and.MA_free_heap(Xr1(2))
      value = value.and.MA_free_heap(Xr2(2))
      value = value.and.MA_free_heap(Er0(2))
      value = value.and.MA_free_heap(Qr(2))
      value = value.and.MA_free_heap(Pr(2))
      if (.not.value)
     >  call errquit('Nose_End: error freeing heap',0,MA_ERR)

      return
      end



*     ***************************
*     *				*
*     *	     Nose_reset_T       *
*     *				*
*     ***************************

      subroutine Nose_reset_T(Te_new,Tr_new)
      implicit none
      real*8 Te_new,Tr_new
     
#include "mafdecls.fh"
#include "nose-hoover.fh"

*     **** boltzman constant ****
      double precision kb
      parameter (kb=3.16679d-6)

*     **** local variables ****
      integer i
      real*8 am,fmass,betae

*     **** external functions ****
      real*8   control_fake_mass
      real*8   ion_amass
      integer  ion_nion
      external control_fake_mass
      external ion_amass
      external ion_nion

      fmass = control_fake_mass()


*     **** reSet Er0(1) = (1/2)*(g*k*T), where g=number of degrees of freedom ****
      if (ion_nion().gt.2) then
        dbl_mb(Er0(1)) = 0.5d0*(3.0d0*dble(ion_nion())-6.0d0)*kb*Tr_new

*     **** Dimer molecule. note that the above formula may not work for ****
*     **** linear molecules with more than two atoms.                   ****
      else
        dbl_mb(Er0(1)) = 0.5d0*(1)*kb*Tr_new
      end if

*     **** reSet Er0(2:Nchain) = 1/2*(k*T) ****
      if (Nchain.gt.1) then
        call dcopy(Nchain-1,0.5d0*kb*Tr_new,0,dbl_mb(Er0(1)+1),1)
      end if

*     **** total mass ****
      am = 0.0d0
      do i=1,ion_nion()
         am = am + ion_amass(i)
      end do

c*     **** reSet Ee0(1) ****
c      Ee0 = 4.0*kb*Te_new*fmass*dble(ion_nion())/am * eke0_init

*     **** Set Ee0(1) - read from rtdb otherwise use current KE ****
      dbl_mb(Ee0(1))=4.0d0*kb*Te_new*fmass*dble(ion_nion())/am*eke0_init

*     **** Set Ee0(2:Mchain) = 1/2*(1/betae), where 1/betae = 2*Ee/Ne ****
      if (Mchain.gt.1) then
        betae = dbl_mb(Ee0(1))/Ne_chain
        call dcopy(Mchain-1,betae,0,dbl_mb(Ee0(1)+1),1)
      end if


      return
      end



*     ***************************
*     *				*
*     *	     Nose_Newton_Step   *
*     *				*
*     ***************************

      subroutine Nose_Newton_Step(eke,eki)
      implicit none
      real*8 eke,eki

#include "mafdecls.fh"
#include "nose-hoover.fh"

*     **** local variables ****
      integer m,n
      real*8 FXe,FXr,dt,a
      real*8 eke_tmp,ekr_tmp

*     **** external functions ****
      real*8   control_time_step
      external control_time_step

      dt = control_time_step()

c      FXe = 2.0d0*(eke-Ee0)
c      Xe2 = (0.5d0*dt*dt/Qe)*FXe

      eke_tmp = eke
      do m=1,Mchain-1

*       *** integrate thermostat using newton step ****
        FXe = 2.0d0*(eke_tmp-dbl_mb(Ee0(1)+m-1))
        a   = dt*(1.0d0 - 0.5d0*dt*dbl_mb(Xem(1)+m))
        dbl_mb(Xe2(1)+m-1) =   dbl_mb(Xe1(1)+m-1)
     >                     + a*dbl_mb(Xem(1)+m-1)
     >                     + (0.5d0*dt*dt/dbl_mb(Qe(1)+m-1))*FXe

*       **** define kinetic energy for next link in the chain ****
        eke_tmp = dbl_mb(Xem(1)+m-1)
        eke_tmp = 0.5d0*dbl_mb(Qe(1)+m-1)*(eke_tmp**2)
      end do
      FXe = 2.0d0*(eke_tmp-dbl_mb(Ee0(1)+Mchain-1))
      dbl_mb(Xe2(1)+Mchain-1) =    dbl_mb(Xe1(1)+Mchain-1)
     >                        + dt*dbl_mb(Xem(1)+Mchain-1)
     >                        + (0.5d0*dt*dt/dbl_mb(Qe(1)+Mchain-1))*FXe

c      FXr = 2.0d0*(eki-Er0)
c      Xr2 = (0.5d0*dt*dt/Qr)*FXr

      ekr_tmp = eki
      do n=1,Nchain-1

*       *** integrate thermostat using newton step ****
        FXr = 2.0d0*(ekr_tmp-dbl_mb(Er0(1)+n-1))
        a   = dt*(1.0d0 - 0.5d0*dt*dbl_mb(Xrm(1)+n))
        dbl_mb(Xr2(1)+n-1) =   dbl_mb(Xr1(1)+n-1)
     >                     + a*dbl_mb(Xrm(1)+n-1)
     >                     + (0.5d0*dt*dt/dbl_mb(Qr(1)+n-1))*FXr

*       **** define kinetic energy for next link in the chain ****
        ekr_tmp = dbl_mb(Xrm(1)+n-1)
        ekr_tmp = 0.5d0*dbl_mb(Qr(1)+n-1)*(ekr_tmp**2)
      end do
      FXr = 2.0d0*(ekr_tmp-dbl_mb(Er0(1)+Nchain-1))
      dbl_mb(Xr2(1)+Nchain-1) =    dbl_mb(Xr1(1)+Nchain-1)
     >                        + dt*dbl_mb(Xrm(1)+Nchain-1)
     >                        + (0.5d0*dt*dt/dbl_mb(Qr(1)+Nchain-1))*FXr

      return
      end

*     ***************************
*     *                         *
*     *      Nose_Verlet_Step   *
*     *                         *
*     ***************************

      subroutine Nose_Verlet_Step(eke,eki)
      implicit none
      real*8 eke,eki

#include "mafdecls.fh"
#include "nose-hoover.fh"

*     **** local variables ****
      integer m,n
      real*8 eke_tmp,ekr_tmp
      real*8 FXe,dXe,sse,FXr,dXr,ssr,dt

*     **** external functions ****
      real*8   control_time_step
      external control_time_step

      dt = control_time_step()

c      eke_tmp = eke
c      FXe = 2.0d0*(eke_tmp-Ee0)
c      Xe2 = 2.0d0*Xe1 - Xe0 + (dt*dt/Qe)*FXe

      eke_tmp = eke
      do m=1,Mchain-1
*       **** define dXe/dt = (3*Xe(t) - 4*Xe(t-dt) + Xe(t-2*dt))/(2*dt) ****
        dXe = (3.0d0*dbl_mb(Xe1(1)+m)
     >        -4.0d0*dbl_mb(Xe0(1)+m)
     >        +      dbl_mb(Xem(1)+m))/(2.0d0*dt)
        sse = 1.0d0/(1.0d0+0.5d0*dXe*dt)

*       *** integrate thermostat using modified verlet ****
        FXe                = 2.0d0*(eke_tmp-dbl_mb(Ee0(1)+m-1))
        dbl_mb(Xe2(1)+m-1) = dbl_mb(Xe0(1)+m-1)
     >                     + ( dbl_mb(Xe1(1)+m-1) 
     >                     -   dbl_mb(Xe0(1)+m-1) 
     >                     +   (0.5*dt*dt/dbl_mb(Qe(1)+m-1))*FXe
     >                       )*2.0d0*sse

*       **** define kinetic energy for next link in the chain ****
        eke_tmp = (dbl_mb(Xe2(1)+m-1)-dbl_mb(Xe0(1)+m-1))/(2.0d0*dt)
        eke_tmp = 0.5d0*dbl_mb(Qe(1)+m-1)*(eke_tmp**2)
      end do

*     **** Last link of chain ****
      FXe                = 2.0d0*(eke_tmp-dbl_mb(Ee0(1)+Mchain-1))
      dbl_mb(Xe2(1)+Mchain-1) = 2.0d0*dbl_mb(Xe1(1)+Mchain-1) 
     >                        -       dbl_mb(Xe0(1)+Mchain-1) 
     >                        + (dt*dt/dbl_mb(Qe(1)+Mchain-1))*FXe


c      eki_tmp = eki
c      FXr = 2.0d0*(eki_tmp-Er0)
c      Xr2 = 2.0d0*Xr1 - Xr0 + (dt*dt/Qr)*FXr

      ekr_tmp = eki
      do n=1,Nchain-1
*       **** define dXe/dt = (3*Xe(t) - 4*Xe(t-dt) + Xe(t-2*dt))/(2*dt) ****
        dXr = (3.0d0*dbl_mb(Xr1(1)+n)
     >        -4.0d0*dbl_mb(Xr0(1)+n)
     >        +      dbl_mb(Xrm(1)+n))/(2.0d0*dt)
        ssr = 1.0d0/(1.0d0+0.5d0*dXr*dt)

*       *** integrate thermostat using modified verlet ****
        FXr                = 2.0d0*(ekr_tmp-dbl_mb(Er0(1)+n-1))
        dbl_mb(Xr2(1)+n-1) = dbl_mb(Xr0(1)+n-1)
     >                     + ( dbl_mb(Xr1(1)+n-1) 
     >                     -   dbl_mb(Xr0(1)+n-1) 
     >                     +   (0.5*dt*dt/dbl_mb(Qr(1)+n-1))*FXr
     >                       )*2.0d0*ssr

*       **** define kinetic energy for next link in the chain ****
        ekr_tmp = (dbl_mb(Xr2(1)+n-1)-dbl_mb(Xr0(1)+n-1))/(2.0d0*dt)
        ekr_tmp = 0.5d0*dbl_mb(Qr(1)+n-1)*(ekr_tmp**2)
      end do

*     **** Last link of chain ****
      FXr                = 2.0d0*(ekr_tmp-dbl_mb(Er0(1)+Nchain-1))
      dbl_mb(Xr2(1)+Nchain-1) = 2.0d0*dbl_mb(Xr1(1)+Nchain-1) 
     >                        -       dbl_mb(Xr0(1)+Nchain-1) 
     >                        + (dt*dt/dbl_mb(Qr(1)+Nchain-1))*FXr


      return
      end

*     ***************************
*     *                         *
*     *      Nose_dXe           *
*     *                         *
*     ***************************

*     returns the velocity of the first electronic thermostat
*     used for Newton Step

      real*8 function Nose_dXe()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_dXe = dbl_mb(Xem(1))
      return
      end

*     ***************************
*     *                         *
*     *      Nose_dXr           *
*     *                         *
*     ***************************

*     returns the velocity of the first ion thermostat
*     used for Newton Step

      real*8 function Nose_dXr()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_dXr = dbl_mb(Xrm(1))
      return
      end

*     ***************************
*     *                         *
*     *      Nose_sse           *
*     *                         *
*     ***************************

      real*8 function Nose_sse()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"


*     ***** local variables ****
      real*8 dXe,dt

*     **** external functions ****
      real*8   control_time_step
      external control_time_step

      dt = control_time_step()

      dXe         = (3.0d0*dbl_mb(Xe1(1))
     >              -4.0d0*dbl_mb(Xe0(1))
     >              +      dbl_mb(Xem(1)))/(2.0d0*dt)

      Nose_sse = 1.0d0/(1.0d0+0.5d0*dXe*dt)
      return
      end

*     ***************************
*     *                         *
*     *      Nose_ssr           *
*     *                         *
*     ***************************

      real*8 function Nose_ssr()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

*     ***** local variables ****
      real*8 dXr,dt

*     **** external functions ****
      real*8   control_ion_time_step
      external control_ion_time_step

      dt = control_ion_time_step()

      dXr         = (3.0d0*dbl_mb(Xr1(1))
     >              -4.0d0*dbl_mb(Xr0(1))
     >              +      dbl_mb(Xrm(1)))/(2.0d0*dt)
      Nose_ssr = 1.0d0/(1.0d0+0.5d0*dXr*dt)
      return
      end

*     ***************************
*     *                         *
*     *      Nose_shift         *
*     *                         *
*     ***************************

      subroutine Nose_shift()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

      call dcopy(Mchain,dbl_mb(Xe0(1)),1,dbl_mb(Xem(1)),1)
      call dcopy(Mchain,dbl_mb(Xe1(1)),1,dbl_mb(Xe0(1)),1)
      call dcopy(Mchain,dbl_mb(Xe2(1)),1,dbl_mb(Xe1(1)),1)

      call dcopy(Nchain,dbl_mb(Xr0(1)),1,dbl_mb(Xrm(1)),1)
      call dcopy(Nchain,dbl_mb(Xr1(1)),1,dbl_mb(Xr0(1)),1)
      call dcopy(Nchain,dbl_mb(Xr2(1)),1,dbl_mb(Xr1(1)),1)
      return
      end

*     ***************************
*     *                         *
*     *      Nose_e_energy      *
*     *                         *
*     ***************************

      real*8 function Nose_e_energy()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

*     **** local variables ****
      integer m
      real*8 dXe,dt,esum

*     **** external functions ****
      real*8   control_time_step
      external control_time_step

      dt = control_time_step()

      esum = 0.0d0
      do m=1,Mchain
        dXe  = (3.0d0*dbl_mb(Xe1(1)+m-1)
     >         -4.0d0*dbl_mb(Xe0(1)+m-1)
     >         +      dbl_mb(Xem(1)+m-1))/(2.0d0*dt)
c        dXe  = (dbl_mb(Xe2(1)+m-1)-dbl_mb(Xe0(1)+m-1))/(2.0d0*dt)

        esum = esum + 0.5d0*dbl_mb(Qe(1)+m-1)*dXe**2 
     >              + 2.0d0*dbl_mb(Ee0(1)+m-1)*dbl_mb(Xe1(1)+m-1)
      end do

      Nose_e_energy = esum
      return
      end

*     ***************************
*     *                         *
*     *      Nose_r_energy      *
*     *                         *
*     ***************************

      real*8 function Nose_r_energy()
      implicit none

#include "mafdecls.fh"
#include "nose-hoover.fh"

*     **** local variables ****
      integer n
      real*8 dXr,dt,esum

*     **** external functions ****
      real*8   control_time_step
      external control_time_step

      dt = control_time_step()

      esum = 0.0d0
      do n=1,Nchain
        dXr  = (3.0d0*dbl_mb(Xr1(1)+n-1)
     >         -4.0d0*dbl_mb(Xr0(1)+n-1)
     >         +      dbl_mb(Xrm(1)+n-1))/(2.0d0*dt)
c        dXr  = (dbl_mb(Xr2(1)+n-1)-dbl_mb(Xr0(1)+n-1))/(2.0d0*dt)
        esum = esum + 0.5d0*dbl_mb(Qr(1)+n-1)*dXr**2 
     >              + 2.0d0*dbl_mb(Er0(1)+n-1)*dbl_mb(Xr1(1)+n-1)
      end do

      Nose_r_energy = esum
      return
      end


*     *********************
*     *                   *
*     *      Nose_Qe      *
*     *                   *
*     *********************

      real*8 function Nose_Qe(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Qe = dbl_mb(Qe(1)+i-1)
      return
      end


*     *********************
*     *                   *
*     *      Nose_Pe      *
*     *                   *
*     *********************

      real*8 function Nose_Pe(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Pe = dbl_mb(Pe(1)+i-1)
      return
      end


*     *********************
*     *                   *
*     *      Nose_Qr      *
*     *                   *
*     *********************

      real*8 function Nose_Qr(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Qr = dbl_mb(Qr(1)+i-1)
      return
      end

*     *********************
*     *                   *
*     *      Nose_Pr      *
*     *                   *
*     *********************

      real*8 function Nose_Pr(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Pr = dbl_mb(Pr(1)+i-1)
      return
      end


*     *********************
*     *                   *
*     *      Nose_Ee0     *
*     *                   *
*     *********************

      real*8 function Nose_Ee0(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Ee0 = dbl_mb(Ee0(1)+i-1)
      return
      end

*     *********************
*     *                   *
*     *      Nose_Er0     *
*     *                   *
*     *********************

      real*8 function Nose_Er0(i)
      implicit none
      integer i

#include "mafdecls.fh"
#include "nose-hoover.fh"

      Nose_Er0 = dbl_mb(Er0(1)+i-1)
      return
      end

*     *********************
*     *                   *
*     *    Nose_Mchain    *
*     *                   *
*     *********************
      integer function Nose_Mchain()
      implicit none
#include "nose-hoover.fh"
      Nose_Mchain = Mchain
      return
      end

*     *********************
*     *                   *
*     *    Nose_Nchain    *
*     *                   *
*     *********************
      integer function Nose_Nchain()
      implicit none
#include "nose-hoover.fh"
      Nose_Nchain = Nchain
      return
      end
