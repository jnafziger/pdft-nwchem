/*$Id: util_host.c,v 1.6 2003-08-13 18:06:11 edo Exp $*/
#include <stdio.h>
#if defined(CRAY) && !defined(__crayx1)
#include <fortran.h>
#define FATR
#endif
#ifdef WIN32
#include "typesf2c.h"
extern int FATR gethostname(char *, int);
#else
extern int gethostname(char *, size_t);
#endif

#if defined(USE_FCD)
extern int string_to_fortchar(_fcd, int, const char *);
void FATR UTIL_HOSTNAME(name)
     _fcd name;
{
  int namelen = _fcdlen(name);
#else
extern int string_to_fortchar(char *, int, const char *);
void util_hostname_(char *name, int namelen)
{
#endif
/*
  Utility routine to return hostname to FORTRAN

  character*(*) name
  call util_hostname(name)
*/
  char buf[256];

#ifdef DELTA
  (void) string_to_fortchar(name, namelen, "delta");
#else
  if (gethostname(buf, (int) sizeof(buf)) != 0)
    buf[0] = 0;
  (void) string_to_fortchar( name, namelen, buf);
#endif
}
