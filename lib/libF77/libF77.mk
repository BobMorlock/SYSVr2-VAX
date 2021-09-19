#	@(#)libF77.mk	1.9
#	LIBF77 MAKEFILE

INS = install
INSDIR = $(ROOT)/usr/lib
CC = cc
AR = ar
STRIP = strip
CFLAGS= -O

MISC =	Version.o main.o s_rnge.o abort_.o getarg_.o iargc_.o getenv_.o \
	signal_.o s_stop.o s_paus.o system_.o
POW =	pow_ci.o pow_dd.o pow_di.o pow_hh.o pow_ii.o  pow_ri.o pow_zi.o pow_zz.o
CX =	c_abs.o c_cos.o c_div.o c_exp.o c_log.o c_sin.o c_sqrt.o
DCX =	z_abs.o z_cos.o z_div.o z_exp.o z_log.o z_sin.o z_sqrt.o
REAL =	r_abs.o r_acos.o r_asin.o r_atan.o r_atn2.o r_cnjg.o r_cos.o\
	r_cosh.o r_dim.o r_exp.o r_imag.o r_int.o\
	r_lg10.o r_log.o r_mod.o r_nint.o r_sign.o\
	r_sin.o r_sinh.o r_sqrt.o r_tan.o r_tanh.o rand_.o
DBL =	d_abs.o d_acos.o d_asin.o d_atan.o d_atn2.o\
	d_cnjg.o d_cos.o d_cosh.o d_dim.o d_exp.o\
	d_imag.o d_int.o d_lg10.o d_log.o d_mod.o\
	d_nint.o d_prod.o d_sign.o d_sin.o d_sinh.o\
	d_sqrt.o d_tan.o d_tanh.o 
INT =	i_abs.o i_dim.o i_dnnt.o i_indx.o i_len.o i_mod.o i_nint.o i_sign.o
HALF =	h_abs.o h_dim.o h_dnnt.o h_indx.o h_len.o h_mod.o  h_nint.o h_sign.o
CMP =	l_ge.o l_gt.o l_le.o l_lt.o hl_ge.o hl_gt.o hl_le.o hl_lt.o
EFL =	ef1asc_.o ef1cmc_.o
CHAR =	s_cat.o s_cmp.o s_copy.o 
ERF  =  erf_.o erfc_.o derf_.o derfc_.o
XTRA =  cabs.o tanh.o sinh.o mclock_.o outstr_.o subout.o
MIL =	and_l.o or_l.o xor_l.o not_l.o shift_l.o shiftc_l.o \
	bclr_l.o bext_l.o bset_l.o btest_l.o mvbits.o bittab.o \
	and_h.o or_h.o xor_h.o not_h.o shift_h.o shiftc_h.o \
	bclr_h.o bext_h.o bset_h.o btest_h.o 

all:		libF77.a

libF77.a:	$(MISC) $(POW) $(CX) $(DCX) $(REAL) $(DBL) $(INT) $(HALF) \
		$(CMP) $(EFL) $(CHAR) $(ERF) $(XTRA) $(MIL)
		$(AR) r libF77.a $?
	if pdp11; then \
		$(STRIP) libF77.a; \
	else \
		$(STRIP) -r libF77.a; \
		$(AR) ts libF77.a; \
	fi;

.c.o :
	$(CC) -c $(CFLAGS) $<


$(MISC) $(POW) $(CX):	complex
$(DCX) $(REAL):		complex
$(DBL) $(INT):		complex
$(HALF) $(CMP) $(CHAR): complex


install: all
	 $(INS) -f $(INSDIR) libF77.a

clean:
	 -rm -f $(MISC) $(POW) $(CX) $(DCX) $(REAL) $(DBL) $(INT) $(HALF) \
		$(CMP) $(EFL) $(CHAR) $(ERF) $(XTRA)

clobber: clean
	 -rm -f libF77.a
