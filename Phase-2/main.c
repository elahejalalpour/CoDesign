/*
 * In The Name Of God
 * ========================================
 * [] File Name : main.c
 *
 * [] Creation Date : 27-08-2015
 *
 * [] Created By : Elahe Jalalpour (el.jalalpour@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2015 Elahe Jalalpour.
*/
#include <stdio.h>
#include <stdlib.h>
#include "fsl.h"

int main(void)
{
	int a;
	/* Sending data to HEA for the first time */
	write_into_fsl(22855, 0);

	/* Getting data from fsl */
	read_from_fsl(a, 0);

	/*
	 * Adding data with 2**17 so that hardware understands
	 * data should be sent to HEM
	*/
	a = a + 256 * 256;

	/* Sending data to HEM for the first time */
	write_into_fsl(a, 0);

	/* Getting data from fsl */
	read_from_fsl(a, 0);

	/* Sending data to HEA for the second time */
	write_into_fsl(a, 0);

	/* Getting data from fsl */
	read_from_fsl(a, 0);

	/*
	 * Adding data with 2**17 so that hardware understands
	 * data should be sent to HEM
	*/
	a = a + 256 * 256;

	/* Sending data to HEM for the second time */
	write_into_fsl(a, 0);

	/* getting data from fsl */
	read_from_fsl(a, 0);

	return EXIT_SUCCESS;
}
