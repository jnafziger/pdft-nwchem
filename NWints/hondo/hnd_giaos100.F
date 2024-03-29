      subroutine hnd_giaos100(xyzi,expi,coefi,i_nprim,i_ngen,Li,xyzj,
     & expj,coefj,j_nprim,j_ngen,Lj,nint,s10,scr,lscr)
c
c $Id: hnd_giaos100.F,v 1.1 2006-11-16 18:22:19 jochen Exp $
c
c     ----- Wrapper routine that sets the sizes of scratch blocks -----
c
      implicit double precision (a-h,o-z)
#include "hnd_pointers.fh"
      dimension scr(lscr)
c
c Use scratch for temps in integral calculation
c Scratch needs are
c 6*(Li+1)*(Lj+1)
c
c The pointers are defined in hdn_pointers.fh
c
      call hnd_giaos1001(xyzi,expi,coefi,i_nprim,i_ngen,Li,xyzj,expj,
     1 coefj,j_nprim,j_ngen,Lj,nint,s10,scr(gh01(1)),scr(gh01(2)),
     2 scr(gh01(3)),scr(gh01(4)),scr(gh01(5)),scr(gh01(6)))
c
      return
      end
c
      subroutine hnd_giaos1001(xyzi,expi,coefi,i_nprim,i_ngen,Li,xyzj,
     1                 expj,coefj,j_nprim,j_ngen,Lj,nint,s10,
     2                 xs,ys,zs,xxs,yys,zzs)
c
      implicit double precision (a-h,o-z)
#include "nwc_const.fh"
#include "hnd_tol.fh"
      common/hnd_xyzder/xint,yint,zint,t,x0,y0,z0,xi,yi,zi,xj,yj,zj,
     &                  ni,nj,cx,cy,cz
      dimension Nxyz(3),xyzi(3),xyzj(3),expi(i_nprim),expj(j_nprim)
      dimension coefi(i_nprim,i_ngen),coefj(j_nprim,j_ngen)
      dimension s10(nint,3)
      dimension  xs(Li+1,Lj+2), ys(Li+1,Lj+2), zs(Li+1,Lj+2)
      dimension xxs(Li+1,Lj+2),yys(Li+1,Lj+2),zzs(Li+1,Lj+2)
      data rln10 /2.30258d+00/
C
      tol=rln10*itol
c
c     Zero integral array
c
      call dcopy(nint*3,0.0d0,0,s10,1)
c
c     ----- ishell -----
c
      xi=xyzi(1)
      yi=xyzi(2)
      zi=xyzi(3)
      lit = Li + 1
      maxi = lit*(lit+1)/2
      litmod=lit+1
c
c     ----- jshell -----
c
      xj=xyzj(1)
      yj=xyzj(2)
      zj=xyzj(3)
      ljt = Lj + 1
      maxj = ljt*(ljt+1)/2
      ljtmod=ljt+1
c
      tijx=xj
      tijy=yj
      tijz=zj
c
      rr=(xi-xj)**2+(yi-yj)**2+(zi-zj)**2
c
c     ----- i primitive -----
c
      do ig=1, i_nprim
      ai=expi(ig)
      arri=ai*rr
      axi=ai*xi
      ayi=ai*yi
      azi=ai*zi
      csi=coefi(ig,i_ngen)
c
c     ----- j primitive -----
c
      do jg=1,j_nprim
         aj=expj(jg)
         aa=ai+aj
         aa1=1.0d0/aa
         dum=aj*arri*aa1
         if(dum.gt.tol) goto 1000
         fac= exp(-dum)
         csj=coefj(jg,j_ngen)
         ax=(axi+aj*xj)*aa1
         ay=(ayi+aj*yj)*aa1
         az=(azi+aj*zj)*aa1
c
c     ----- density factor -----
c
         cij=csi*csj*fac
c
c     ----- x , y , z integrals -----
c
         t = sqrt(aa1)
         x0=ax
         y0=ay
         z0=az
         do i=1,lit
            ni=i
            do j=1,ljtmod
               nj=j
               call hnd_sxyz
               xs(i,j)=xint*t
               ys(i,j)=yint*t 
               zs(i,j)=zint*t 
            enddo
            do j=1,ljtmod
               xxs(i,j)=xs(i,j+1)
               yys(i,j)=ys(i,j+1)
               zzs(i,j)=zs(i,j+1)
            enddo
         enddo
c
         ij=0
         do j=1,maxj
            call getNxyz(Lj,j,Nxyz)
            jx = Nxyz(1) + 1
            jy = Nxyz(2) + 1
            jz = Nxyz(3) + 1
            do i=1,maxi
               call getNxyz(Li,i,Nxyz)
               ix = Nxyz(1) + 1
               iy = Nxyz(2) + 1
               iz = Nxyz(3) + 1
               ij=ij+1
               dum = xs(ix,jx)* ys(iy,jy)* zs(iz,jz)
               dumx=xxs(ix,jx)* ys(iy,jy)* zs(iz,jz)
               dumy= xs(ix,jx)*yys(iy,jy)* zs(iz,jz)
               dumz= xs(ix,jx)* ys(iy,jy)*zzs(iz,jz)
               s10(ij,1)=s10(ij,1)-cij*(tijy*dumz-tijz*dumy)
               s10(ij,2)=s10(ij,2)-cij*(tijz*dumx-tijx*dumz)
               s10(ij,3)=s10(ij,3)-cij*(tijx*dumy-tijy*dumx)
            enddo
         enddo
c
 1000 continue
c
      enddo
      enddo
c
      return
      end
