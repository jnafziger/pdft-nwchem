      subroutine smd_mass_init_system()
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "util.fh"
#include "global.fh"
c     
      character*32 sp_mass,sp_param,sp_type
      character*32 tag,pname
      logical result

      pname = "smd_mass_init_system"
c
      tag = "type"
      call smd_system_get_component(sp_type,tag,result)
      if(.not.result)
     >  call errquit(
     >       pname//'no component '//tag,0,0)

      tag = "parameters"
      call smd_system_get_component(sp_param,tag,result)
      if(.not.result)
     >  call errquit(
     >       pname//'no component '//tag,0,0)

      tag = "mass"
      call smd_system_get_component(sp_mass,tag,result)
      if(.not.result)
     >  call errquit(
     >       pname//'no component '//tag,0,0)


      call smd_mass_init(sp_mass)
c
      return
      end

      subroutine smd_mass_init(sp_mass)
      implicit none
#include "errquit.fh"
#include "inp.fh"
#include "mafdecls.fh"
#include "rtdb.fh"
#include "util.fh"
#include "global.fh"
c     
      character*(*) sp_mass
c
      character*32 pname
      character*80 tag
      integer na
      integer i_it
      integer i_mp,i_m,nmp
      logical result
c
      pname = "smd_mass_init"
c
c      write(*,*) "in "//pname
c
c     get type array
c     --------------
      tag = "type:id"
      call smd_get_ind_dim(tag,i_it,na,result)
      if(.not. result) 
     >  call errquit(
     >       pname//'error getting index for'//tag,0, 0)
c
c     get mass parameter array
c     ------------------------
      tag = "param:mass"
      call smd_get_ind_dim(tag,i_mp,nmp,result)
      if(.not. result) 
     >  call errquit(
     >       pname//'error getting index for'//tag,0, 0)
c
c     create mass structure
c     ---------------------
      call smd_namespace_create(sp_mass)
      tag = "mass"
      call smd_data_create_get(sp_mass,tag,na,MT_DBL,i_m)

      call smd_mass_set(na,
     +                  int_mb(i_it),
     +                  dbl_mb(i_mp),
     +                  dbl_mb(i_m))


      return
      end
c
      subroutine smd_mass_set(na,it,mp,m)
      implicit none
#include "mafdecls.fh"
#include "errquit.fh"
#include "util.fh"
#include "inp.fh"
      integer na
      integer it(na)
      double precision  mp(*)
      double precision m(na)
c
      integer i,j
 
      do i=1,na
       j=it(i)
       m(i) = mp(j)
      end do

      return
      end

