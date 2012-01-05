/*
 $Id: schrodin.h,v 1.1 2001-08-30 16:58:37 bylaska Exp $
*/
#ifndef _SCHRODINGER_H_
#define _SCHRODINGER_H_
/* Schrodinger.h - 6/9/95
   author     - Eric Bylaska

   This file contains routines for integrating the radial
   Schodinger equation.

*/

extern void   R_Schrodinger();
extern void   R_Schrodinger_Fixed_E();
extern void   R_Schrodinger_Fixed_Logderiv();

#endif
