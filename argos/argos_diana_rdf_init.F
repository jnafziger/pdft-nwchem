      subroutine argos_diana_rdf_init()
c
c $Id: argos_diana_rdf.F,v 1.1 2006-12-10 01:03:22 d3j191 Exp $
c
      implicit none
c
#include "argos_diana_common.fh"
#include "global.fh"
#include "mafdecls.fh"
#include "msgids.fh"
#include "rtdb.fh"
c
      if(.not.ma_push_get(mt_int,nrdf*nsel*mwa,'irdf',l_rdf,i_rdf))
     + call md_abort('Could not allocate irdf',0)
      print*,'rdf allocated in rdfhdr ',nrdf*nsel*mwa
c
      return
      end
