/* UNIX HEADER */
#include	<stdio.h>

/* COMMON SGS HEADERS */
#include	"filehdr.h"
#include	"ldfcn.h"


    /*  checkflags(filename, &filehead)
     *
     *  checks and sets object file header flags appropriately
     *
     *  checkflags returns SUCCESS or FAILURE
     *
     *  checkflags will FAIL (and strip won't strip) in the following cases:
     *  if there is no symbol table (strip announces the fact if lflag or xflag
     *  imply that symbols were expected)
     *  if lflag or xflag is ON and there are no local symbols 
     *  if lflag is OFF and there are relocation entries 
     *
     *  the file flags in the file header are set to reflect the new state of
     *  of the file:
     *  if both xflag and lflag are OFF there will be no symbols nor any line
     *  numbers in the file
     *  if xflag is ON then there will be no local symbols nor any line numbers
     *  if lflag is ON then there will be no line numbers
     */


int
checkflags(filename, filehead)

char	*filename;
FILHDR	*filehead;

{
    /* STRIP FUNCTION CALLED */
    extern		error( );

    /* EXTERNAL VARIABLES USED */
    extern LDFILE	*ldptr;
    extern int		lflag,
			xflag,
			sflag,
			rflag;
	extern int	fflag;

    /* LOCAL VARIABLE */
    unsigned short	filflags;

    if (filehead->f_nsyms == 0L) {
	if (lflag || xflag || rflag || sflag || fflag ) {
	    error(filename, "no symbol table", 1);
	   onintr();
	}
	return(FAILURE);

    } else if (!(lflag || xflag || rflag || sflag || fflag)) {
	filehead->f_nsyms = 0L;
    }

    filflags = filehead->f_flags;

    if (sflag && (filflags & F_LSYMS) != 0)
    {
	    error(filename, "no local symbols", 1);
	    return(FAILURE);
    }

	if (((!rflag) && (!fflag) && (!lflag)) && (filflags & F_RELFLG) == 0) {
	    error(filename, "relocation entries; cannot strip", 1);
	    return(FAILURE);
	}

#if !UNIX
	if (fflag && !(filflags & F_EXEC)) {
		error( filename, "not executable, cannot strip", 1);
		return( FAILURE );
	}
#endif

    return(SUCCESS);
}
/*
 *	static char ID[] = "@(#) checkflags.c: 1.5 8/18/83";
 */
