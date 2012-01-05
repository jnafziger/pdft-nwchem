#ifndef _PAW_COMP_CHARGE_H_
#define _PAW_COMP_CHARGE_H_
/*
   $Id: paw_comp_charge.h,v 1.2 2004-10-14 22:05:02 bylaska Exp $
*/


extern void paw_init_comp_charge( double );
extern double paw_boundary_function(double );
extern double paw_find_sigma_comp();
extern double* paw_find_comp_charge_potential(double,double , double);
extern double paw_get_sigma_comp();
extern double paw_get_comp_charge_radius();
extern void  paw_print_comp_charge_information(FILE *fp);

#endif

