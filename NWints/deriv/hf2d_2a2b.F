      subroutine hf2d_2a2b(
     &      Axyz,Aprims,Acoefs,NPA,NCA,La,ictra,
     &      Bxyz,Bprims,Bcoefs,NPB,NCB,Lb,ictrb,
     &      Cxyz,Cprims,Ccoefs,NPC,NCC,Lc,ictrc,
     &      Dxyz,Dprims,Dcoefs,NPD,NCD,Ld,ictrd,
     &      bERI,Nint,canAB,canCD,canPQ,dryrun,
     &      W0,maxW0)
C $Id: hf2d_2a2b.F,v 1.3 2000-10-25 22:50:04 windus Exp $
      Implicit None
      Logical canAB,canCD,canPQ,dryrun
      
c--> Cartesian Coordinates, Primitives & Contraction Coefficients
      
      Integer La, Lb, Lc, Ld, Nint, MaxW0
      Integer NPA, NCA, NPB, NCB, NPC, NCC, NPD, NCD
      Double Precision Axyz(3),Aprims(NPA),Acoefs(NPA,NCA)
      Double Precision Bxyz(3),Bprims(NPB),Bcoefs(NPB,NCB)
      Double Precision Cxyz(3),Cprims(NPC),Ccoefs(NPC,NCC)
      Double Precision Dxyz(3),Dprims(NPD),Dcoefs(NPD,NCD)
      Integer ictra,ictrb,ictrc,ictrd
c--> Block of Electron Repulsion Integrals
      
      Double Precision bERI(Nint,*)
      
c--> Scratch Space
      
      Double Precision W0(maxW0)
c
      integer npa1, npa2, npb1, npb2
      integer a_exp, a_cof, b_exp, b_cof
      integer k0s, maxw0new, pw0, kaddint, icont
      integer mem1, mem2, mem3, mem4
      integer mem1add, mem2add, mem3add, mem4add
c
      npa1  = npa/2
      if (mod(npa,2).eq.1) npa1 = npa1 + 1
      npa2 = npa - npa1
      npb1  = npb/2
      if (mod(npb,2).eq.1) npb1 = npb1 + 1
      npb2 = npb - npb1
c... do first of 4 blocks  (a1|b1|*)
      a_exp  = 1
      a_cof  = a_exp + npa1
      b_exp  = a_cof + npa1*NCA
      b_cof  = b_exp + npb1
      k0s    = b_cof + npb1*NCB
      maxw0new = maxw0 - k0s

      mem1    = k0s         ! take care of compiler warnings
      mem2    = k0s
      mem3    = k0s
      mem1add = mem1
      mem2add = mem2
      mem3add = mem3
      mem4add = mem3

      if (dryrun) then
        mem1add = k0s
      else
        call dcopy(npa1,Aprims,1,W0(a_exp),1)
        call dcopy(npb1,Bprims,1,W0(b_exp),1)
        do 00100 icont = 1,NCA
          pw0 = a_cof+(icont-1)*npa1
          call dcopy(npa1,Acoefs(1,icont),1,W0(pw0),1)
00100   continue
        do 00200 icont = 1,NCB
          pw0 = b_cof+(icont-1)*npb1
          call dcopy(npb1,Bcoefs(1,icont),1,W0(pw0),1)
00200   continue
      endif
      call hf2dold(
     &    Axyz,W0(a_exp),W0(a_cof),NPA1,NCA,La,ictra,
     &    Bxyz,W0(b_exp),W0(b_cof),NPB1,NCB,Lb,ictrb,
     &    Cxyz,Cprims,Ccoefs,NPC,NCC,Lc,ictrc,
     &    Dxyz,Dprims,Dcoefs,NPD,NCD,Ld,ictrd,
     &    bERI,Nint,canAB,canCD,canPQ,dryrun,
     &    W0(k0s),maxW0new)
c
      if (dryrun) mem1 = maxW0new + mem1add
c
c... do second of 4 blocks   (a1|b2|*)
      b_cof  = b_exp + npb2
      kaddint = b_cof + npb2*NCB
      k0s = kaddint + 12*nint
      maxw0new = maxw0 - k0s
      if (dryrun) then
        mem2add = k0s
      else
        call dcopy(npb2,Bprims(npb1+1),1,W0(b_exp),1)
        do 00300 icont = 1,NCB
          pw0 = b_cof+(icont-1)*npb2
          call dcopy(npb2,Bcoefs((npb1+1),icont),1,W0(pw0),1)
00300   continue
      endif
      call hf2dold(
     &    Axyz,W0(a_exp),W0(a_cof),NPA1,NCA,La,ictra,
     &    Bxyz,W0(b_exp),W0(b_cof),NPB2,NCB,Lb,ictrb,
     &    Cxyz,Cprims,Ccoefs,NPC,NCC,Lc,ictrc,
     &    Dxyz,Dprims,Dcoefs,NPD,NCD,Ld,ictrd,
     &    W0(kaddint),Nint,canAB,canCD,canPQ,dryrun,
     &    W0(k0s),maxW0new)
      if (dryrun) then
        mem2 = maxw0new + mem2add
      else
c... sum blocks 1+2
        call daxpy((nint*12),1.0d00,w0(kaddint),1,beri,1)
      endif
c
c... do third of 4 blocks   (a2|b1|*)
      a_exp  = 1
      a_cof  = a_exp + npa2
      b_exp  = a_cof + npa2*NCA
      b_cof  = b_exp + npb1
      kaddint = b_cof + npb1*NCB
      k0s = kaddint + 12*nint
      maxw0new = maxw0 - k0s
      if (dryrun) then
        mem3add = k0s
      else
        call dcopy(npa2,Aprims(npa1+1),1,W0(a_exp),1)
        call dcopy(npb1,Bprims,1,W0(b_exp),1)
        do 00400 icont = 1,NCA
          pw0 = a_cof+(icont-1)*npa2
          call dcopy(npa2,Acoefs((npa1+1),icont),1,W0(pw0),1)
00400   continue
        do 00500 icont = 1,NCB
          pw0 = b_cof+(icont-1)*npb1
          call dcopy(npb1,Bcoefs(1,icont),1,W0(pw0),1)
00500   continue
      endif
      call hf2dold(
     &    Axyz,W0(a_exp),W0(a_cof),NPA2,NCA,La,ictra,
     &    Bxyz,W0(b_exp),W0(b_cof),NPB1,NCB,Lb,ictrb,
     &    Cxyz,Cprims,Ccoefs,NPC,NCC,Lc,ictrc,
     &    Dxyz,Dprims,Dcoefs,NPD,NCD,Ld,ictrd,
     &    W0(kaddint),Nint,canAB,canCD,canPQ,dryrun,
     &    W0(k0s),maxW0new)
      if (dryrun) then
        mem3 = maxw0new + mem3add
      else
c... sum blocks 1,2 + 3
        call daxpy((nint*12),1.0d00,w0(kaddint),1,beri,1)
      endif
c
c... do fourth of 4 blocks   (a2|b2|*)
      b_cof  = b_exp + npb2
      kaddint = b_cof + npb2*NCB
      k0s = kaddint + 12*nint
      maxw0new = maxw0 - k0s
      if (dryrun) then
        mem4add = k0s
      else
        call dcopy(npb2,Bprims(npb1+1),1,W0(b_exp),1)
        do 00600 icont = 1,NCB
          pw0 = b_cof+(icont-1)*npb2
          call dcopy(npb2,Bcoefs((npb1+1),icont),1,W0(pw0),1)
00600   continue
      endif
      call hf2dold(
     &    Axyz,W0(a_exp),W0(a_cof),NPA2,NCA,La,ictra,
     &    Bxyz,W0(b_exp),W0(b_cof),NPB2,NCB,Lb,ictrb,
     &    Cxyz,Cprims,Ccoefs,NPC,NCC,Lc,ictrc,
     &    Dxyz,Dprims,Dcoefs,NPD,NCD,Ld,ictrd,
     &    W0(kaddint),Nint,canAB,canCD,canPQ,dryrun,
     &    W0(k0s),maxW0new)
      if (dryrun) then
        mem4 = maxw0new + mem4add
        maxw0 = max(mem1,mem2,mem3,mem4)
      else
c... sum blocks 1,2,3 + 4
        call daxpy((nint*12),1.0d00,w0(kaddint),1,beri,1)
      endif
c
      end
