/*	@(#) _ec_quit.c: 1.1 10/15/83	(1.21	2/11/83)	*/

#include "curses.ext"

#ifndef 	NONSTANDARD
/*
 * Emergency quit.  Called at startup only if something wrong in
 * initializing termcap.
 */
_ec_quit(msg, parm)
char *msg, *parm;
{
#ifdef DEBUG
	if(outf) fprintf(outf, "_ec_quit(%s,%s).\n", msg, parm);
#endif
	reset_shell_mode();
	fprintf(stderr, msg, parm);
	exit(1);
}
#endif	 	NONSTANDARD
