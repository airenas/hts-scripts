# Process this file with autoconf to produce a configure script.
AC_INIT(HTS-demo_CMU-ARCTIC-ADAPT, 2.3.2, hts-users@sp.nitech.ac.jp)
AC_COPYRIGHT(Copyright 2001-2017 Nagoya Institute of Technology)
AC_COPYRIGHT(Copyright 2001-2008 Tokyo Institute of Technology)
AC_COPYRIGHT(Copyright 2008 University of Edinburgh)



# Checks for programs.
# awk
AC_PROG_AWK

# perl
AC_PATH_PROG([PERL], [perl], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$PERL"; then
	AC_MSG_ERROR(Can't find perl)
fi

# python
AC_PATH_PROG([PYTHON], [python], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$PYTHON"; then
	if test -z "$USEDNN"; then
		:
	elif test $USEDNN -ne 1; then
		:
	else
		AC_MSG_ERROR(Can't find python)
	fi
fi
PYTHON="$PYTHON -u -B"

# wc
AC_PATH_PROG([WC], [wc], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$WC"; then
	AC_MSG_ERROR(Can't find wc)
fi



# festival
# festival search path
AC_ARG_WITH(fest-search-path,
		AS_HELP_STRING([--with-fest-search-path],[specify the additional festival search path]),
		[fest_search_path=$withval])

# text2utt
AC_PATH_PROG([TEXT2UTT], [text2utt], [:], [${fest_search_path}:$PATH])
if test ! -f "$TEXT2UTT"; then
	AC_MSG_ERROR(Can't find text2utt of festival)
fi

# dumpfeats
AC_PATH_PROG([DUMPFEATS], [dumpfeats], [:], [${fest_search_path}:$PATH])
if test ! -f "$DUMPFEATS"; then
	AC_MSG_ERROR(Can't find dumpfeats of festival)
fi



# SPTK commands
# SPTK search path
AC_ARG_WITH(sptk-search-path,
		AS_HELP_STRING([--with-sptk-search-path],[specify the additional SPTK binary search path]),
		[sptk_search_path=$withval])

# x2x
AC_PATH_PROG([X2X], [x2x], [:], [${sptk_search_path}:$PATH])
if test ! -f "$X2X"; then
	AC_MSG_ERROR(Can't find x2x of SPTK)
fi

# frame
AC_PATH_PROG([FRAME], [frame], [:], [${sptk_search_path}:$PATH])
if test ! -f "$FRAME"; then
	AC_MSG_ERROR(Can't find frame of SPTK)
fi

# window
AC_PATH_PROG([WINDOW], [window], [:], [${sptk_search_path}:$PATH])
if test ! -f "$WINDOW"; then
	AC_MSG_ERROR(Can't find window of SPTK)
fi

# mgcep
if test -z "$GAMMA"; then
	AC_PATH_PROG([MGCEP], [mcep], [:], [${sptk_search_path}:$PATH])
	if test ! -f "$MGCEP"; then
		AC_MSG_ERROR(Can't find mcep of SPTK)
	fi
elif test $GAMMA -eq 0; then
	AC_PATH_PROG([MGCEP], [mcep], [:], [${sptk_search_path}:$PATH])
	if test ! -f "$MGCEP"; then
		AC_MSG_ERROR(Can't find mcep of SPTK)
	fi
else
	AC_PATH_PROG([MGCEP], [mgcep], [:], [${sptk_search_path}:$PATH])
	if test ! -f "$MGCEP"; then
		AC_MSG_ERROR(Can't find mgcep of SPTK)
	fi
fi

# lpc2lsp
AC_PATH_PROG([LPC2LSP], [lpc2lsp], [:], [${sptk_search_path}:$PATH])
if test ! -f "$LPC2LSP"; then
	AC_MSG_ERROR(Can't find lpc2lsp of SPTK)
fi

# nan
AC_PATH_PROG([NAN], [nan], [:], [${sptk_search_path}:$PATH])
if test ! -f "$NAN"; then
	AC_MSG_ERROR(Can't find nan of SPTK)
fi

# bcut
AC_PATH_PROG([BCUT], [bcut], [:], [${sptk_search_path}:$PATH])
if test ! -f "$BCUT"; then
	AC_MSG_ERROR(Can't find bcut of SPTK)
fi

# vstat
AC_PATH_PROG([VSTAT], [vstat], [:], [${sptk_search_path}:$PATH])
if test ! -f "$VSTAT"; then
	AC_MSG_ERROR(Can't find vstat of SPTK)
fi

# sopr
AC_PATH_PROG([SOPR], [sopr], [:], [${sptk_search_path}:$PATH])
if test ! -f "$SOPR"; then
	AC_MSG_ERROR(Can't find sopr of SPTK)
fi

# vopr
AC_PATH_PROG([VOPR], [vopr], [:], [${sptk_search_path}:$PATH])
if test ! -f "$VOPR"; then
	AC_MSG_ERROR(Can't find vopr of SPTK)
fi

# vsum
AC_PATH_PROG([VSUM], [vsum], [:], [${sptk_search_path}:$PATH])
if test ! -f "$VSUM"; then
	AC_MSG_ERROR(Can't find vsum of SPTK)
fi

# freqt
AC_PATH_PROG([FREQT], [freqt], [:], [${sptk_search_path}:$PATH])
if test ! -f "$FREQT"; then
	AC_MSG_ERROR(Can't find freqt of SPTK)
fi

# c2acr
AC_PATH_PROG([C2ACR], [c2acr], [:], [${sptk_search_path}:$PATH])
if test ! -f "$C2ACR"; then
	AC_MSG_ERROR(Can't find c2acr of SPTK)
fi

# mc2b
AC_PATH_PROG([MC2B], [mc2b], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MC2B"; then
	AC_MSG_ERROR(Can't find mc2b of SPTK)
fi

# b2mc
AC_PATH_PROG([B2MC], [b2mc], [:], [${sptk_search_path}:$PATH])
if test ! -f "$B2MC"; then
	AC_MSG_ERROR(Can't find b2mc of SPTK)
fi

# merge
AC_PATH_PROG([MERGE], [merge], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MERGE"; then
	AC_MSG_ERROR(Can't find merge of SPTK)
fi

# bcp
AC_PATH_PROG([BCP], [bcp], [:], [${sptk_search_path}:$PATH])
if test ! -f "$BCP"; then
	AC_MSG_ERROR(Can't find bcp of SPTK)
fi

# excite
AC_PATH_PROG([EXCITE], [excite], [:], [${sptk_search_path}:$PATH])
if test ! -f "$EXCITE"; then
	AC_MSG_ERROR(Can't find excite of SPTK)
fi

# lsp2lpc
AC_PATH_PROG([LSP2LPC], [lsp2lpc], [:], [${sptk_search_path}:$PATH])
if test ! -f "$LSP2LPC"; then
	AC_MSG_ERROR(Can't find lsp2lpc of SPTK)
fi

# lspcheck
AC_PATH_PROG([LSPCHECK], [lspcheck], [:], [${sptk_search_path}:$PATH])
if test ! -f "$LSPCHECK"; then
	AC_MSG_ERROR(Can't find lspcheck of SPTK)
fi

# mgc2mgc
AC_PATH_PROG([MGC2MGC], [mgc2mgc], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MGC2MGC"; then
	AC_MSG_ERROR(Can't find mgc2mgc of SPTK)
fi

# mglsadf
AC_PATH_PROG([MGLSADF], [mglsadf], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MGLSADF"; then
	AC_MSG_ERROR(Can't find mglsadf of SPTK)
fi

# dfs
AC_PATH_PROG([DFS], [dfs], [:], [${sptk_search_path}:$PATH])
if test ! -f "$DFS"; then
	AC_MSG_ERROR(Can't find dfs of SPTK)
fi

# mgc2sp
AC_PATH_PROG([MGC2SP], [mgc2sp], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MGC2SP"; then
	AC_MSG_ERROR(Can't find mgc2sp of SPTK)
fi

# minmax
AC_PATH_PROG([MINMAX], [minmax], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MINMAX"; then
	AC_MSG_ERROR(Can't find minmax of SPTK)
fi

# swab
AC_PATH_PROG([SWAB], [swab], [:], [${sptk_search_path}:$PATH])
if test ! -f "$SWAB"; then
	AC_MSG_ERROR(Can't find swab of SPTK)
fi

# raw2wav
AC_PATH_PROG([RAW2WAV], [raw2wav], [:], [${sptk_search_path}:$PATH])
if test ! -f "$RAW2WAV"; then
	AC_MSG_ERROR(Can't find raw2wav of SPTK)
fi

# wav2raw
AC_PATH_PROG([WAV2RAW], [wav2raw], [:], [${sptk_search_path}:$PATH])
if test ! -f "$WAV2RAW"; then
	AC_MSG_ERROR(Can't find wav2raw of SPTK)
fi

# pitch
AC_PATH_PROG([PITCH], [pitch], [:], [${sptk_search_path}:$PATH])
if test ! -f "$PITCH"; then
	AC_MSG_ERROR(Can't find pitch of SPTK)
fi

# mlpg
AC_PATH_PROG([MLPG], [mlpg], [:], [${sptk_search_path}:$PATH])
if test ! -f "$MLPG"; then
	AC_MSG_ERROR(Can't find mlpg of SPTK)
fi

# interpolate
AC_PATH_PROG([INTERPOLATE], [interpolate], [:], [${sptk_search_path}:$PATH])
if test ! -f "$INTERPOLATE"; then
	AC_MSG_ERROR(Can't find interpolate of SPTK)
fi



# MATLAB
# MATLAB search path
AC_ARG_WITH(matlab-search-path,
		AS_HELP_STRING([--with-matlab-search-path],[specify the additional MATLAB binary search path]),
		[matlab_search_path=$withval])
AC_PATH_PROG([MATLAB], [matlab], [:], [${matlab_search_path}:$PATH])
if test ! -f "$MATLAB"; then
	if test -z "$USESTRAIGHT"; then
		:
	elif test $USESTRAIGHT -ne 1; then
		:
	else
		AC_MSG_ERROR(Can't find MATLAB)
	fi
fi
MATLAB="$MATLAB -nodisplay -nosplash -nojvm"



# STRAIGHT
# STRAIGHT search path
AC_ARG_WITH(straight-path,
		AS_HELP_STRING([--with-straight-path],[specify the STRAIGHT MATLAB code path]),
		[STRAIGHT=$withval])
if test ! -f "$STRAIGHT/exstraightsource.p" -a ! -f "$STRAIGHT/exstraightsource.m"; then
	if test -z "$USESTRAIGHT"; then
		:
	elif test $USESTRAIGHT -ne 1; then
		:
	else
		AC_MSG_ERROR(Can't find exstraightsource in $STRAIGHT)
	fi
fi
if test ! -f "$STRAIGHT/exstraightspec.p"   -a ! -f "$STRAIGHT/exstraightspec.m";   then
	if test -z "$USESTRAIGHT"; then
		:
	elif test $USESTRAIGHT -ne 1; then
		:
	else
		AC_MSG_ERROR(Can't find exstraightspec in $STRAIGHT)
	fi
fi
if test ! -f "$STRAIGHT/exstraightsynth.p"  -a ! -f "$STRAIGHT/exstraightsynth.m";  then
	if test -z "$USESTRAIGHT"; then
		:
	elif test $USESTRAIGHT -ne 1; then
		:
	else
		AC_MSG_ERROR(Can't find exstraightsynth in $STRAIGHT)
	fi
fi
AC_SUBST(STRAIGHT)



# HTS commands
# HTS search path
AC_ARG_WITH(hts-search-path,
		AS_HELP_STRING([--with-hts-search-path],[specify the additional HTS binary search path]),
		[hts_search_path=$withval])

# HMGenS
AC_PATH_PROG([HMGENS], [HMGenS], [:], [${hts_search_path}:$PATH])
if test ! -f "$HMGENS"; then
	AC_MSG_ERROR(Can't find HMGenS of HTS)
fi

# HCompV
AC_PATH_PROG([HCOMPV], [HCompV], [:], [${hts_search_path}:$PATH])
if test ! -f "$HCOMPV"; then
	AC_MSG_ERROR(Can't find HCompV of HTS)
fi

# HList
AC_PATH_PROG([HLIST],  [HList],  [:], [${hts_search_path}:$PATH])
if test ! -f "$HLIST"; then
	AC_MSG_ERROR(Can't find HList of HTS)
fi

# HInit
AC_PATH_PROG([HINIT],  [HInit],  [:], [${hts_search_path}:$PATH])
if test ! -f "$HINIT"; then
	AC_MSG_ERROR(Can't find HInit of HTS)
fi

# HRest
AC_PATH_PROG([HREST],  [HRest],  [:], [${hts_search_path}:$PATH])
if test ! -f "$HREST"; then
	AC_MSG_ERROR(Can't find HRest of HTS)
fi

# HERest
AC_PATH_PROG([HEREST], [HERest], [:], [${hts_search_path}:$PATH])
if test ! -f "$HEREST"; then
	AC_MSG_ERROR(Can't find HERest of HTS)
fi

# HHEd
AC_PATH_PROG([HHED],   [HHEd],   [:], [${hts_search_path}:$PATH])
if test ! -f "$HHED"; then
	AC_MSG_ERROR(Can't find HHEd of HTS)
fi

# HSMMAlign
AC_PATH_PROG([HSMMALIGN],   [HSMMAlign],   [:], [${hts_search_path}:$PATH])
if test ! -f "$HSMMALIGN"; then
	AC_MSG_ERROR(Can't find HSMMAlign of HTS)
fi



# hts_engine API
# hts_engine search path
AC_ARG_WITH(hts-engine-search-path,
		AS_HELP_STRING([--with-hts-engine-search-path],[specify the additional hts_engine binary search path]),
		[hts_engine_search_path=$withval])

# hts_engine
AC_PATH_PROG([ENGINE], [hts_engine], [:], [${hts_engine_search_path}:$PATH])
if test ! -f "$ENGINE"; then
	if test -z "$USESTRAIGHT"; then
		AC_MSG_ERROR(Can't find hts_engine)
	elif test $USESTRAIGHT -ne 1; then
		AC_MSG_ERROR(Can't find hts_engine)
	else
		:
	fi
fi



# fullcontext label format
AC_ARG_VAR([FULLCONTEXT_FORMAT],[full context label format (default=HTS_TTS_ENG)])
AC_ARG_VAR([FULLCONTEXT_VERSION],[version of full context label format (default=1.0)])

if test -z "$FULLCONTEXT_FORMAT"; then
	FULLCONTEXT_FORMAT=HTS_TTS_ENG
fi

if test -z "$FULLCONTEXT_VERSION"; then
	FULLCONTEXT_VERSION=1.0
fi

AC_SUBST(FULLCONTEXT_FORMAT)
AC_SUBST(FULLCONTEXT_VERSION)



# speaker and dataset names
AC_ARG_VAR([DATASET],[dataset (default=cmu_us_arctic)])
AC_ARG_VAR([TRAINSPKR],[speakers for training (default='bdl clb jmk rms')])
AC_ARG_VAR([ADAPTSPKR],[speakers for adaptation (default=slt)])
AC_ARG_VAR([ADAPTHEAD],[file name header for adaptation data (default=b05)])

if test -z "$DATASET"; then
	DATASET=cmu_us_arctic
fi

if test -z "$TRAINSPKR"; then
	TRAINSPKR='bdl clb jmk rms'
fi

if test -z "$ADAPTSPKR"; then
	ADAPTSPKR=slt
fi

if test -z "$ADAPTHEAD"; then
	ADAPTHEAD=b05
fi

AC_SUBST(DATASET)
AC_SUBST(TRAINSPKR)
AC_SUBST(ADAPTSPKR)
AC_SUBST(ADAPTHEAD)



# version number and question set name
AC_ARG_VAR([VER],[version number of this setting (default=1)])
AC_ARG_VAR([QNAME],[question set name (default=en_US.talk)])

if test -z "$VER"; then
	VER=1
fi

if test -z "$QNAME"; then
	QNAME=en_US.talk
fi

AC_SUBST(VER)
AC_SUBST(QNAME)



# current directory
AC_SUBST(PWD)



# setting of mel-generalized cepstral analysis, F0 extraction, and postfiltering related settings
# parse command-line arguments
AC_ARG_VAR([USEUTT],[generate labels from utt files instead of text files (0:off or 1:on, default=1)])
AC_ARG_VAR([USESTRAIGHT],[turn on STRAIGHT-based analysis (0:off or 1:on, default=0)])
AC_ARG_VAR([FRAMELEN],[frame length in point (default=1200)])
AC_ARG_VAR([FRAMESHIFT],[frame shift in point (default=240)])
AC_ARG_VAR([WINDOWTYPE],[window type -> 0: Blackman  1: Hamming  2: Hanning (default=1)])
AC_ARG_VAR([NORMALIZE],[normalization -> 0: none  1: by power  2: by magnitude (default=1)])
AC_ARG_VAR([SAMPFREQ],[sampling frequency in Hz (default=48000)])
AC_ARG_VAR([FFTLEN],[FFT length in point (default=2048)])
AC_ARG_VAR([FREQWARP],[frequency warping factor (default=0.55)])
AC_ARG_VAR([GAMMA],[pole/zero weight factor (0: mel-cepstral analysis  1: LPC analysis  2,3,...,N: mel-generalized cepstral (MGC) analysis) (default=0)])
AC_ARG_VAR([MGCORDER],[order of MGC analysis (default=34 for cepstral form, default=12 for LSP form)])
AC_ARG_VAR([BAPORDER],[order of BAP analysis (default=24)])
AC_ARG_VAR([LNGAIN],[use logarithmic gain instead of linear gain (default=1)])
AC_ARG_VAR([PSTFILTER_MCP],[postfiltering factor for mel-cepstral (default=1.4)])
AC_ARG_VAR([PSTFILTER_LSP],[postfiltering factor for LSP (default=0.7)])
AC_ARG_VAR([IMPLEN],[length of impulse response (default=4096 for cepstral form, default=576 for LSP form)])
AC_ARG_VAR([USEGV],[use global variance (0:off or 1:on, default=0)])

# default values
if test -z "$USEUTT"; then
	USEUTT=1
fi

if test -z "$USEGV"; then
	USEGV=0
fi

if test -z "$USESTRAIGHT"; then
	USESTRAIGHT=0
fi

if test -z "$FRAMELEN"; then
	FRAMELEN=1200
fi

if test -z "$FRAMESHIFT"; then
	FRAMESHIFT=240
fi

if test -z "$WINDOWTYPE"; then
	WINDOWTYPE=1
fi

if test -z "$NORMALIZE"; then
	NORMALIZE=1
fi

if test -z "$SAMPFREQ"; then
	SAMPFREQ=48000
fi

if test "$USESTRAIGHT" -eq 1; then
	if test $SAMPFREQ -le 25600; then
		FFTLEN=1024
	elif test $SAMPFREQ -le 51200; then
		FFTLEN=2048
	elif test $SAMPFREQ -le 102400; then
		FFTLEN=4096
	else
		FFTLEN=8192
	fi
else
	if test -z "$FFTLEN"; then
		FFTLEN=2048
	fi
fi

if test -z "$FREQWARP"; then
	case $SAMPFREQ in
		8000)  FREQWARP=0.31 ;;
		10000) FREQWARP=0.35 ;;
		12000) FREQWARP=0.37 ;;
		16000) FREQWARP=0.42 ;;
		20000) FREQWARP=0.44 ;;
		22050) FREQWARP=0.45 ;;
		32000) FREQWARP=0.50 ;;
		44100) FREQWARP=0.53 ;;
		48000) FREQWARP=0.55 ;;
		*)     FREQWARP=0.00 ;;
	esac
fi

if test -z "$GAMMA"; then
	GAMMA=0
fi

if test -z "$MGCORDER"; then
	if test $GAMMA -eq 0; then
		MGCORDER=34
	else
		MGCORDER=12
	fi
fi

if test -z "$BAPORDER"; then
	BAPORDER=24
fi

if test -z "$LNGAIN"; then
	LNGAIN=1
fi

if test -z "$PSTFILTER_MCP"; then
	PSTFILTER_MCP=1.4
fi

if test -z "$PSTFILTER_LSP"; then
	PSTFILTER_LSP=0.7
fi

if test -z "$IMPLEN"; then
	if test $GAMMA -eq 0; then
		IMPLEN=4096
	else
		IMPLEN=576
	fi
fi

MGCVSIZE=`expr $MGCORDER + 1`
BAPVSIZE=`expr $BAPORDER + 1`

if test $GAMMA -lt 0; then
	AC_MSG_ERROR(Cannot use MGC coefficients if GAMMA<0!)
fi



# substitute variables
AC_SUBST(USEUTT)
AC_SUBST(USESTRAIGHT)
AC_SUBST(FRAMELEN)
AC_SUBST(FRAMESHIFT)
AC_SUBST(WINDOWTYPE)
AC_SUBST(NORMALIZE)
AC_SUBST(SAMPFREQ)
AC_SUBST(FFTLEN)
AC_SUBST(FREQWARP)
AC_SUBST(GAMMA)
AC_SUBST(MGCORDER)
AC_SUBST(BAPORDER)
AC_SUBST(PSTFILTER_MCP)
AC_SUBST(PSTFILTER_LSP)
AC_SUBST(IMPLEN)
AC_SUBST(MGCVSIZE)
AC_SUBST(BAPVSIZE)
AC_SUBST(USEGV)



# F0 search range
AC_ARG_VAR([F0_RANGES],[F0 search ranges (spkr1 lower1 upper1  spkr2 lower2 upper2...). Order of speakers in F0_RANGES should be equal to that in ALLSPKR (default='bdl 40 210 clb 130 260 jmk 50 180 rms 40 200 slt 110 280')])

# default values
if test -z "$F0_RANGES"; then
	F0_RANGES='bdl 40 210 clb 130 260 jmk 50 180 rms 40 200 slt 110 280'
fi

AC_SUBST(F0_RANGES)



# number of windows
# parse command-line arguments
AC_ARG_VAR([NMGCWIN],[number of delta windows for MGC coefficients (default=3)])
AC_ARG_VAR([NLF0WIN],[number of delta windows for log F0 values (default=3)])
AC_ARG_VAR([NBAPWIN],[number of delta windows for band aperiodicity values (default=3)])

# default values
if test -z "$NMGCWIN"; then
	NMGCWIN=3
fi

if test -z "$NLF0WIN"; then
	NLF0WIN=3
fi

if test -z "$NBAPWIN"; then
	NBAPWIN=3
fi

MGCSTRST=1
MGCSTREN=1
LF0STRST=`expr $MGCSTREN + 1`
LF0STREN=`expr $MGCSTREN + $NLF0WIN`
BAPSTRST=`expr $LF0STREN + 1`
BAPSTREN=`expr $LF0STREN + 1`

# substitute variables
AC_SUBST(NMGCWIN)
AC_SUBST(NLF0WIN)
AC_SUBST(NBAPWIN)
AC_SUBST(MGCSTRST)
AC_SUBST(MGCSTREN)
AC_SUBST(LF0STRST)
AC_SUBST(LF0STREN)
AC_SUBST(BAPSTRST)
AC_SUBST(BAPSTREN)



# model training settings
# parse command-line arguments
AC_ARG_VAR([NSTATE],[number of HMM states (default=5)])
AC_ARG_VAR([NITER],[number of iterations of embedded training (default=5)])
AC_ARG_VAR([WFLOOR],[mixture weight flooring scale (default=5000)])
AC_ARG_VAR([DAEM],[DAEM algorithm for parameter estimation (0:off or 1:on, default=0)])
AC_ARG_VAR([DAEMNITER],[number of iterations of DAEM-based embedded training (default=10)])
AC_ARG_VAR([DAEMALPHA],[schedule of updating temperature parameter for DAEM (default=1.0)])
AC_ARG_VAR([MAXDEV],[maximum duration scaling factor (default=10)])
AC_ARG_VAR([MINDUR],[minimum duration to be evaluated (default=5)])

# default values
if test -z "$NSTATE"; then
	NSTATE=5
fi

if test -z "$NITER"; then
	NITER=5
fi

if test -z "$WFLOOR"; then
	WFLOOR=5000
fi

if test -z "$DAEM"; then
	DAEM=0
fi

if test -z "$DAEMNITER"; then
	DAEMNITER=10
fi

if test -z "$DAEMALPHA"; then
	DAEMALPHA=1.0
fi

if test -z "$MAXDEV"; then
	MAXDEV=10
fi

if test -z "$MINDUR"; then
	MINDUR=5
fi

# substitute variables
AC_SUBST(NSTATE)
AC_SUBST(NITER)
AC_SUBST(WFLOOR)
AC_SUBST(DAEM)
AC_SUBST(DAEMNITER)
AC_SUBST(DAEMALPHA)
AC_SUBST(MAXDEV)
AC_SUBST(MINDUR)


# adaptation settings
# parse command-line arguments
AC_ARG_VAR([NMGCTRANSBLK],[number of blocks for MGC transforms (default=3)])
AC_ARG_VAR([NLF0TRANSBLK],[number of blocks for log F0 transforms (default=1)])
AC_ARG_VAR([NBAPTRANSBLK],[number of blocks for band aperiodicity transforms (default=3)])
AC_ARG_VAR([MGCBANDWIDTH],[band width for MGC transforms (default=35 for cepstral form, derault=2 for LSP form)])
AC_ARG_VAR([LF0BANDWIDTH],[band width for log F0 transforms (default=1)])
AC_ARG_VAR([BAPBANDWIDTH],[band width for band aperiodicity transforms (default=25)])
AC_ARG_VAR([TREEKIND],[regression class tree kind (dec: decision tree, reg: regression tree, default=dec)])
AC_ARG_VAR([SATTREEKIND],[regression class tree kind for SAT (dec: decision tree, reg: regression tree, default=dec)])
AC_ARG_VAR([TRANSKIND],[adaptation transform kind (mean: MLLRMEAN, cov: MLLRCOV, feat: CMLLR, default=feat)])
AC_ARG_VAR([DECMGCOCCTHRESH],[occupancy threshold for regression classes of MGC stream (default=500.0)])
AC_ARG_VAR([DECLF0OCCTHRESH],[occupancy threshold for regression classes of log F0 streams (default=100.0)])
AC_ARG_VAR([DECBAPOCCTHRESH],[occupancy threshold for regression classes of band aperiodicity streams (default=100.0)])
AC_ARG_VAR([DECDUROCCTHRESH],[occupancy threshold for regression classes of duration models (default=50.0)])
AC_ARG_VAR([MGCOCCTHRESH],[occupancy threshold to adapt MGC stream (default=500.0)])
AC_ARG_VAR([LF0OCCTHRESH],[occupancy threshold to adapt log F0 streams (default=100.0)])
AC_ARG_VAR([BAPOCCTHRESH],[occupancy threshold to adapt band aperiodicity streams (default=100.0)])
AC_ARG_VAR([DUROCCTHRESH],[occupancy threshold to adapt duration models (default=50.0)])
AC_ARG_VAR([SATMGCOCCTHRESH],[occupancy threshold for adaptive training of MGC stream (default=10000.0)])
AC_ARG_VAR([SATLF0OCCTHRESH],[occupancy threshold for adaptive training of log F0 streams (default=2000.0)])
AC_ARG_VAR([SATBAPOCCTHRESH],[occupancy threshold for adaptive training of band aperiodicity streams (default=2000.0)])
AC_ARG_VAR([SATDUROCCTHRESH],[occupancy threshold for adaptive training of duration models (default=5000.0)])
AC_ARG_VAR([NUMADAPT],[number of adaption transform reestimation iterations (default=3)])
AC_ARG_VAR([NUMSAT],[number of speaker adaptive training iterations (default=3)])
AC_ARG_VAR([CMPBIAS],[use bias for MLLRMEAN/CMLLR adaptation (cmp) (default=TRUE)])
AC_ARG_VAR([DURBIAS],[use bias for MLLRMEAN/CMLLR adaptation (dur) (default=TRUE)])
AC_ARG_VAR([USEDCOV],[use diagonal covariance transform for MLLRMEAN (default=FALSE)])
AC_ARG_VAR([USEMAPLR],[use MAPLR adaptation for MLLRMEAN/CMLLR (default=TRUE)])
AC_ARG_VAR([USEVBLR],[use VBLR adaptation for MLLRMEAN (default=FALSE)])
AC_ARG_VAR([USESTRUCTURALPRIOR],[use structural prior for MAPLR/VBLR with regression class tree (default=TRUE)])
AC_ARG_VAR([PRIORSCALE],[hyper-parameter for SMAPLR/SVBLR adaptation (default=1.0)])
AC_ARG_VAR([ADDMAP],[add MAP adaptation after MLLR adaptation (default=1)])
AC_ARG_VAR([CMPMAPTAU],[hyper-parameter for MAP adaptation (default=50.0)])
AC_ARG_VAR([DURMAPTAU],[hyper-parameter for MAP adaptation (default=50.0)])

# default values
if test -z "$NMGCTRANSBLK"; then
	NMGCTRANSBLK=3
fi

if test -z "$NLF0TRANSBLK"; then
	NLF0TRANSBLK=1
fi

if test -z "$NBAPTRANSBLK"; then
	NBAPTRANSBLK=3
fi

if test -z "$MGCBANDWIDTH"; then
	if test $GAMMA -eq 0; then
		MGCBANDWIDTH=$MGCVSIZE
	else
		MGCBANDWIDTH=2
	fi
fi

if test -z "$LF0BANDWIDTH"; then
	LF0BANDWIDTH=1
fi

if test -z "$BAPBANDWIDTH"; then
	BAPBANDWIDTH=$BAPVSIZE
fi

if test -z "$TREEKIND"; then
	TREEKIND=dec
fi

if test -z "$SATTREEKIND"; then
	SATTREEKIND=dec
fi

if test -z "$TRANSKIND"; then
	TRANSKIND=feat
fi

if test -z "$DECMGCOCCTHRESH"; then
	DECMGCOCCTHRESH=500.0
fi

if test -z "$DECLF0OCCTHRESH"; then
	DECLF0OCCTHRESH=100.0
fi

if test -z "$DECBAPOCCTHRESH"; then
	DECBAPOCCTHRESH=100.0
fi

if test -z $DECDUROCCTHRESH; then
	DECDUROCCTHRESH=50.0
fi

if test -z "$MGCOCCTHRESH"; then
	MGCOCCTHRESH=500.0
fi

if test -z "$LF0OCCTHRESH"; then
	LF0OCCTHRESH=100.0
fi

if test -z "$BAPOCCTHRESH"; then
	BAPOCCTHRESH=100.0
fi

if test -z $DUROCCTHRESH; then
	DUROCCTHRESH=50.0
fi

if test -z $SATMGCOCCTHRESH; then
	SATMGCOCCTHRESH=10000.0
fi

if test -z $SATLF0OCCTHRESH; then
	SATLF0OCCTHRESH=2000.0
fi

if test -z $SATBAPOCCTHRESH; then
	SATBAPOCCTHRESH=2000.0
fi

if test -z $SATDUROCCTHRESH; then
	SATDUROCCTHRESH=5000.0
fi

if test -z $NUMADAPT; then
	NUMADAPT=3
fi

if test -z $NUMSAT; then
	NUMSAT=3
fi

if test -z $CMPBIAS; then
	CMPBIAS=TRUE
fi

if test -z $DURBIAS; then
	DURBIAS=TRUE
fi

if test -z $USEDCOV; then
	USEDCOV=FALSE
fi

if test -z $USEMAPLR; then
	USEMAPLR=TRUE
fi

if test -z $USEVBLR; then
	USEVBLR=FALSE
fi

if test -z $USESTRUCTURALPRIOR; then
	USESTRUCTURALPRIOR=TRUE
fi

if test -z $PRIORSCALE; then
	PRIORSCALE=1.0
fi

if test -z $ADDMAP; then
	ADDMAP=1
fi
if test $ADDMAP -eq 1; then
	if test $TRANSKIND != 'feat'; then
		AC_MSG_ERROR(Currently only cascade of CMLLR and MAP estimation is supported)
	fi
fi

if test -z $CMPMAPTAU; then
	CMPMAPTAU=50.0
fi

if test -z $DURMAPTAU; then
	DURMAPTAU=50.0
fi

# substitute variables
AC_SUBST(NMGCTRANSBLK)
AC_SUBST(NLF0TRANSBLK)
AC_SUBST(NBAPTRANSBLK)
AC_SUBST(MGCBANDWIDTH)
AC_SUBST(LF0BANDWIDTH)
AC_SUBST(BAPBANDWIDTH)
AC_SUBST(TREEKIND)
AC_SUBST(SATTREEKIND)
AC_SUBST(TRANSKIND)
AC_SUBST(DECMGCOCCTHRESH)
AC_SUBST(DECLF0OCCTHRESH)
AC_SUBST(DECBAPOCCTHRESH)
AC_SUBST(DECDUROCCTHRESH)
AC_SUBST(MGCOCCTHRESH)
AC_SUBST(LF0OCCTHRESH)
AC_SUBST(BAPOCCTHRESH)
AC_SUBST(DUROCCTHRESH)
AC_SUBST(SATMGCOCCTHRESH)
AC_SUBST(SATLF0OCCTHRESH)
AC_SUBST(SATBAPOCCTHRESH)
AC_SUBST(SATDUROCCTHRESH)
AC_SUBST(NUMADAPT)
AC_SUBST(NUMSAT)
AC_SUBST(CMPBIAS)
AC_SUBST(DURBIAS)
AC_SUBST(USEDCOV)
AC_SUBST(USEMAPLR)
AC_SUBST(USEVBLR)
AC_SUBST(USESTRUCTURALPRIOR)
AC_SUBST(PRIORSCALE)
AC_SUBST(ADDMAP)
AC_SUBST(CMPMAPTAU)
AC_SUBST(DURMAPTAU)


# parameter generation algorithm settings
# parse command-line arguments
AC_ARG_VAR([PGTYPE],[type of speech parameter generation algorithm (0: Cholesky, 1: MixHidden, 2: StateHidden, default=0)])
AC_ARG_VAR([MAXEMITER],[max EM iteration (default=20)])
AC_ARG_VAR([EMEPSILON],[convergence factor for EM iteration (default=0.0001)])
AC_ARG_VAR([USEHMMGV],[turn on GV-based parameter generation algorithm (0:off or 1:on, default=1)])
AC_ARG_VAR([MAXGVITER],[maximum number of iterations of GV-based parameter generation algorithm (default=50)])
AC_ARG_VAR([GVEPSILON],[convergence factor for GV iteration (default=0.0001)])
AC_ARG_VAR([MINEUCNORM],[minimum Euclid norm for GV iteration (default=0.01)])
AC_ARG_VAR([STEPINIT],[initial step size (default=1.0)])
AC_ARG_VAR([STEPINC],[step size acceleration factor (default=1.2)])
AC_ARG_VAR([STEPDEC],[step size deceleration factor (default=0.5)])
AC_ARG_VAR([HMMWEIGHT],[weight for HMM output prob. (default=1.0)])
AC_ARG_VAR([GVWEIGHT],[weight for GV output prob. (default=1.0)])
AC_ARG_VAR([OPTKIND],[optimization method (STEEPEST, NEWTON, or LBFGS) (default=NEWTON)])
AC_ARG_VAR([NOSILGV],[turn on GV without silent and pause phoneme (0:off or 1:on, default=1)])
AC_ARG_VAR([CDGV],[turn on context-dependent GV (0:off or 1:on, default=1)])

# default values
if test -z "$PGTYPE"; then
	PGTYPE=0
fi

if test -z "$MAXEMITER"; then
	MAXEMITER=20
fi

if test -z "$EMEPSILON"; then
	EMEPSILON=0.0001
fi

if test -z "$USEHMMGV"; then
	USEHMMGV=1
fi

if test -z "$MAXGVITER"; then
	MAXGVITER=50
fi

if test -z "$GVEPSILON"; then
	GVEPSILON=0.0001
fi

if test -z "$MINEUCNORM"; then
	MINEUCNORM=0.01
fi

if test -z "$STEPINIT"; then
	STEPINIT=1.0
fi

if test -z "$STEPINC"; then
	STEPINC=1.2
fi

if test -z "$STEPDEC"; then
	STEPDEC=0.5
fi

if test -z "$HMMWEIGHT"; then
	HMMWEIGHT=1.0
fi

if test -z "$GVWEIGHT"; then
	GVWEIGHT=1.0
fi

if test -z "$OPTKIND"; then
	OPTKIND=NEWTON
fi

if test -z "$NOSILGV"; then
	NOSILGV=1
fi

if test -z "$CDGV"; then
	CDGV=1
fi

# substitute variables
AC_SUBST(PGTYPE)
AC_SUBST(MAXEMITER)
AC_SUBST(EMEPSILON)
AC_SUBST(USEHMMGV)
AC_SUBST(MAXGVITER)
AC_SUBST(GVEPSILON)
AC_SUBST(MINEUCNORM)
AC_SUBST(STEPINIT)
AC_SUBST(STEPINC)
AC_SUBST(STEPDEC)
AC_SUBST(HMMWEIGHT)
AC_SUBST(GVWEIGHT)
AC_SUBST(OPTKIND)
AC_SUBST(NOSILGV)
AC_SUBST(CDGV)


# neural network training settings
# parse command-line arguments
AC_ARG_VAR([USEDNN],[use deep neural network as acoustic model (0:off or 1:on, default=0)])
AC_ARG_VAR([NHIDDENUNITS],[number of hidden units in each layer (1st 2nd 3rd ...) (default='2048 2048 2048 2048 2048')])
AC_ARG_VAR([ACTIVATION],[activation function for hidden units -> 0: Linear  1: Sigmoid  2: Tanh  3: ReLU (default=1)])
AC_ARG_VAR([OPTIMIZER],[optimizer -> 0: SGD  1: Momentum  2: AdaGrad  3: AdaDelta  4: Adam  5: RMSprop (default=4)])
AC_ARG_VAR([LEARNRATE],[learning rate (default=0.001)])
AC_ARG_VAR([KEEPPROB],[probability for not randomly setting activities to zero (default=0.5)])
AC_ARG_VAR([QUEUESIZE],[queue size (default=10000)])
AC_ARG_VAR([BATCHSIZE],[mini-batch size (default=512)])
AC_ARG_VAR([NEPOCH],[number of epochs for training (default=100)])
AC_ARG_VAR([NADAPTEPOCH],[number of epochs for training (default=50)])
AC_ARG_VAR([NTHREAD],[number of threads (0:unlimited, default=0)])
AC_ARG_VAR([RANDOMSEED],[random seed for initialization (default=12345)])

# default values
if test -z "$USEDNN"; then
	USEDNN=0
elif test $USEDNN -eq 1; then
	if test `$PYTHON -c 'import tensorflow as tf; print(tf.__version__)' 2>&1 >/dev/null | grep -c Error` -gt 0; then
		AC_MSG_ERROR(Can't find TensorFlow)
	fi
fi

if test -z "$NHIDDENUNITS"; then
	NHIDDENUNITS='2048 2048 2048 2048 2048'
fi

if test -z "$ACTIVATION"; then
	ACTIVATION=1
fi

if test -z "$OPTIMIZER"; then
	OPTIMIZER=4
fi

if test -z "$LEARNRATE"; then
	LEARNRATE=0.001
fi

if test -z "$KEEPPROB"; then
	KEEPPROB=0.5
fi

if test -z "$QUEUESIZE"; then
	QUEUESIZE=10000
fi

if test -z "$BATCHSIZE"; then
	BATCHSIZE=512
fi

if test -z "$NEPOCH"; then
	NEPOCH=100
fi

if test -z "$NADAPTEPOCH"; then
	NADAPTEPOCH=50
fi

if test -z "$NTHREAD"; then
	NTHREAD=0
fi

if test -z "$RANDOMSEED"; then
	RANDOMSEED=12345
fi

# substitute variables
AC_SUBST(USEDNN)
AC_SUBST(NHIDDENUNITS)
AC_SUBST(ACTIVATION)
AC_SUBST(OPTIMIZER)
AC_SUBST(LEARNRATE)
AC_SUBST(KEEPPROB)
AC_SUBST(QUEUESIZE)
AC_SUBST(BATCHSIZE)
AC_SUBST(NEPOCH)
AC_SUBST(NADAPTEPOCH)
AC_SUBST(NTHREAD)
AC_SUBST(RANDOMSEED)


# output Makefiles and config file
AC_OUTPUT(data/Makefile Makefile scripts/Config.pm)
