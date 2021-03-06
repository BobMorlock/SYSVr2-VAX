	.file	"execv.s"
#	@(#)execv.s	1.5
# C library -- execv

# execv(file, argv);

# where argv is a vector argv[0] ... argv[x], 0
# last vector element must be 0

.globl	_execv
.globl	_environ
.globl	_execve

_execv:
	.word	0x0000
	MCOUNT
	pushl	_environ	#  default environ
	pushl	8(ap)		#  argv
	pushl	4(ap)		#  file
	calls	$3,_execve
	ret
