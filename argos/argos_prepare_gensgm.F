      logical function argos_prepare_gensgm(lfnout,lfnfrg,lfnsgm,
     + lsgm,csgm,msgm,nsgm)
c
c $Id: argos_prepare_gensgm.F,v 1.10 2003-10-19 03:30:58 d3j191 Exp $
c
c     function to generate segment files
c
c     in  : lfnfrg    = fragment file logical file number
c           lfnsgm    = segment file logical file number
c           lfnout    = output file logical file number
c           mseq      = dimension of the sequence list
c           lsgm(1,i) = number of segments of type i
c           lsgm(2,i) = source: 0=not found; 1=s; 2=x; 3=u; 4=t;
c           csgm(i)   = segment name
c
      implicit none
c
#include "mafdecls.fh"
#include "util.fh"
#include "argos_prepare_common.fh"
c
c
      logical argos_prepare_mksgm
      external argos_prepare_mksgm
c
      integer lfnout,lfnfrg,lfnsgm
      integer msgm,nsgm
      integer lsgm(3,msgm)
      character*5 csgm(msgm)
c
      character*255 filfrg,filsgm,dirnam,dirnm2
c
      integer len,len2,length
      integer i
c
      if(util_print('where',print_debug)) then
      write(lfnout,2000)
 2000 format(/,'argos_prepare_gensgm ')
      endif
c
      do 1 i=1,nsgm
      if(lsgm(2,i).lt.0) then
c
      length=index(csgm(i),' ')-1
      if(length.le.0) length=5
c
      dirnam=dirpar(-lsgm(2,i))
      len=index(dirnam,' ')-1
      dirnm2=dirpar(mdirpar)
      len2=index(dirnm2,' ')-1
c
      filfrg=dirnam(1:len)//csgm(i)(1:length)//'.frg '
      filsgm=dirnm2(1:len2)//csgm(i)(1:length)//'.sgm '
c
      if(util_print('where',print_debug)) then
      write(lfnout,2001) filfrg(1:index(filfrg,' ')-1),
     + filsgm(1:index(filsgm,' ')-1)
 2001 format(' Converting ',a,'into ',a)
      endif
c
      if(.not.argos_prepare_mksgm(lfnout,lfnfrg,filfrg,lfnsgm,filsgm))
     + call md_abort('argos_prepare_mksgm failed',9999)
c
      lsgm(2,i)=mdirpar
      endif
    1 continue
c
      argos_prepare_gensgm=.true.
      return
c
 9999 continue
      argos_prepare_gensgm=.false.
      return
      end
 
 
 
