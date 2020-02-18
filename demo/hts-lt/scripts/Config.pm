#!/usr/bin/perl
# ----------------------------------------------------------------- #
#           The HMM-Based Speech Synthesis System (HTS)             #
#           developed by HTS Working Group                          #
#           http://hts.sp.nitech.ac.jp/                             #
# ----------------------------------------------------------------- #
#                                                                   #
#  Copyright (c) 2001-2017  Nagoya Institute of Technology          #
#                           Department of Computer Science          #
#                                                                   #
#                2001-2008  Tokyo Institute of Technology           #
#                           Interdisciplinary Graduate School of    #
#                           Science and Engineering                 #
#                                                                   #
#                2008       University of Edinburgh                 #
#                           Centre for Speech Technology Research   #
#                                                                   #
# All rights reserved.                                              #
#                                                                   #
# Redistribution and use in source and binary forms, with or        #
# without modification, are permitted provided that the following   #
# conditions are met:                                               #
#                                                                   #
# - Redistributions of source code must retain the above copyright  #
#   notice, this list of conditions and the following disclaimer.   #
# - Redistributions in binary form must reproduce the above         #
#   copyright notice, this list of conditions and the following     #
#   disclaimer in the documentation and/or other materials provided #
#   with the distribution.                                          #
# - Neither the name of the HTS working group nor the names of its  #
#   contributors may be used to endorse or promote products derived #
#   from this software without specific prior written permission.   #
#                                                                   #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND            #
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,       #
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF          #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE          #
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS #
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,          #
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED   #
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,     #
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON #
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   #
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    #
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE           #
# POSSIBILITY OF SUCH DAMAGE.                                       #
# ----------------------------------------------------------------- #


# Settings ==============================
$fclf        = 'HTS_TTS_ENG';
$fclv        = '1.0';
$dset        = 'lab';
$spkr        = 'URB';
$trainSpkr   = 'BRO JOK';
$qname       = 'qst001';
$ver         = '1';
$usestraight = '0';

@SET        = ('cmp', 'dur');
if ( !$usestraight ) {
   @cmp     = ('mgc', 'lf0');
}
else {
   @cmp     = ('mgc', 'lf0', 'bap');
}
@dur        = ('dur');
$ref{'cmp'} = \@cmp;
$ref{'dur'} = \@dur;

%vflr = ('mgc' => '0.01',           # variance floors
         'lf0' => '0.01',
         'bap' => '0.01',
         'dur' => '0.01');

%thr  = ('mgc' => '000',            # minimum likelihood gain in clustering
         'lf0' => '000',
         'bap' => '000',
         'dur' => '000');

%mdlf = ('mgc' => '1.0',            # tree size control param. for MDL
         'lf0' => '1.0',
         'bap' => '1.0',
         'dur' => '1.0');

%mocc = ('mgc' => '10.0',           # minimum occupancy counts
         'lf0' => '10.0',
         'bap' => '10.0',
         'dur' => ' 5.0');

%gam  = ('mgc' => '000',            # stats load threshold
         'lf0' => '000',
         'bap' => '000',
         'dur' => '000');

%t2s  = ('mgc' => 'cmp',            # feature type to mmf conversion
         'lf0' => 'cmp',
         'bap' => 'cmp',
         'dur' => 'dur');

%strb = ('mgc' => '1',     # stream start
         'lf0' => '2',
         'bap' => '5',
         'dur' => '1');

%stre = ('mgc' => '1',     # stream end
         'lf0' => '4',
         'bap' => '5',
         'dur' => '5');

%msdi = ('mgc' => '0',              # msd information
         'lf0' => '1',
         'bap' => '0',
         'dur' => '0');

%strw = ('mgc' => '1.0',            # stream weights
         'lf0' => '1.0',
         'bap' => '0.0',
         'dur' => '1.0');

%ordr = ('mgc' => '35',     # feature order
         'lf0' => '1',
         'bap' => '25',
         'dur' => '5');

%nwin = ('mgc' => '3',      # number of windows
         'lf0' => '3',
         'bap' => '3',
         'dur' => '0');

%gvthr  = ('mgc' => '000',          # minimum likelihood gain in clustering for GV
           'lf0' => '000',
           'bap' => '000');

%gvmdlf = ('mgc' => '1.0',          # tree size control for GV
           'lf0' => '1.0',
           'bap' => '1.0');

%gvgam  = ('mgc' => '000',          # stats load threshold for GV
           'lf0' => '000',
           'bap' => '000');

@slnt   = ('pau', 'h#', 'brth');    # silent and pause phoneme

%mdcp   = ();                       # model copy


# Speech Analysis/Synthesis Setting ==============
# speech analysis
$sr = 44100;   # sampling rate (Hz)
$fs = 220; # frame period (point)
$ft = 2048;     # FFT length (point)
$fw = 0.53;   # frequency warping
$gm = 0;      # pole/zero representation weight
$lg = 1;     # use log gain instead of linear gain

# speech synthesis
$pf_mcp = 1.4; # postfiltering factor for mel-cepstrum
$pf_lsp = 0.7; # postfiltering factor for LSP
$fl     = 4096;        # length of impulse response
$co     = 2047;            # order of cepstrum to approximate mel-cepstrum


# Speaker adaptation Setting ============
$spkrPat = "\"*/lab_%%%_*\"";       # speaker name pattern

# regression classes
%dect = ('mgc' => '500.0',    # occupancy thresholds for regression classes (dec)
         'lf0' => '100.0',    # set thresholds in less than adpt and satt
         'bap' => '100.0',
         'dur' => '50.0');

$nClass = 32;                             # number of regression classes (reg)

# transforms
%nblk = ('mgc' => '3',       # number of blocks for transforms
         'lf0' => '1',
         'bap' => '3',
         'dur' => '1');

%band = ('mgc' => '35',       # band width for transforms
         'lf0' => '1',
         'bap' => '25',
         'dur' => '0');

$bias{'cmp'} = 'TRUE';               # use bias term for MLLRMEAN/CMLLR
$bias{'dur'} = 'TRUE';
$tran        = 'feat';             # transformation kind (mean -> MLLRMEAN, cov -> MLLRCOV, or feat -> CMLLR)

# adaptation
%adpt = ('mgc' => '500.0',       # occupancy thresholds for adaptation
         'lf0' => '100.0',
         'bap' => '100.0',
         'dur' => '50.0');

$tknd{'adp'}   = 'dec';            # tree kind (dec -> decision tree or reg -> regression tree (k-means))
$dcov          = 'FALSE';             # use diagonal covariance transform for MLLRMEAN
$usemaplr      = 'TRUE';            # use MAPLR adaptation for MLLRMEAN/CMLLR
$usevblr       = 'FALSE';             # use VBLR adaptation for MLLRMEAN
$sprior        = 'TRUE';  # use structural prior for MAPLR/VBLR with regression class tree
$priorscale    = 1.0;            # hyper-parameter for SMAPLR adaptation
$nAdapt        = 3;              # number of iterations to reestimate adaptation xforms
$addMAP        = 1;                # apply additional MAP estimation after MLLR adaptation
$maptau{'cmp'} = 50.0;             # hyper-parameters for MAP adaptation
$maptau{'dur'} = 50.0;

# speaker adaptive training
%satt = ('mgc' => '10000.0',    # occupancy thresholds for adaptive training
         'lf0' => '2000.0',
         'bap' => '2000.0',
         'dur' => '5000.0');

$tknd{'sat'} = 'dec';           # tree kind (dec -> decision tree or reg -> regression tree (k-means))
$nSAT        = 3;                  # number of SAT iterations


# Modeling/Generation Setting ==============
# modeling
$nState      = 5;        # number of states
$nIte        = 5;         # number of iterations for embedded training
$beam        = '1500 100 5000'; # initial, inc, and upper limit of beam width
$maxdev      = 10;        # max standard dev coef to control HSMM maximum duration
$mindur      = 5;        # min state duration to be evaluated
$wf          = 5000;        # mixture weight flooring
$initdurmean = 3.0;             # initial mean of state duration
$initdurvari = 10.0;            # initial variance of state duration
$daem        = 0;          # DAEM algorithm based parameter estimation
$daem_nIte   = 10;     # number of iterations of DAEM-based embedded training
$daem_alpha  = 1.0;     # schedule of updating temperature parameter for DAEM

# generation
$pgtype     = 0;     # parameter generation algorithm (0 -> Cholesky, 1 -> MixHidden, 2 -> StateHidden)
$maxEMiter  = 20;  # max EM iteration
$EMepsilon  = 0.0001;  # convergence factor for EM iteration
$useGV      = 0;      # turn on GV
$maxGViter  = 50;  # max GV iteration
$GVepsilon  = 0.0001;  # convergence factor for GV iteration
$minEucNorm = 0.01; # minimum Euclid norm for GV iteration
$stepInit   = 1.0;   # initial step size
$stepInc    = 1.2;    # step size acceleration factor
$stepDec    = 0.5;    # step size deceleration factor
$hmmWeight  = 1.0;  # weight for HMM output prob.
$gvWeight   = 1.0;   # weight for GV output prob.
$optKind    = 'NEWTON';  # optimization method (STEEPEST, NEWTON, or LBFGS)
$nosilgv    = 1;    # GV without silent and pause phoneme
$cdgv       = 1;       # context-dependent GV

# neural network
$useDNN       = 0;         # train a deep neural network after HMM training
$nHiddenUnits = '2048 2048 2048 2048 2048'; # number of hidden units in each layer
$activation   = 1;     # activation function for hidden units  (0 -> Linear, 1 -> Sigmoid, 2 -> Tanh, 3 -> ReLU)
$optimizer    = 4;      # optimizer (0 -> SGD, 1 -> Momentum, 2 -> AdaGrad, 3-> AdaDelta, 4 -> Adam, 5 -> RMSprop)
$learnRate    = 0.001;      # learning rate
$keepProb     = 0.5;       # probability for not randomly setting activities to zero
$queueSize    = 10000;      # queue size
$batchSize    = 512;      # mini-batch size
$nEpoch       = 100;         # number of epochs for training
$nAdaptEpoch  = 50;    # number of epochs for adaptation
$nThread      = 0;        # number of threads
$randomSeed   = 12345;     # random seed used for initialization
$nKeep        = 5;                # number of models to keep
$logInterval  = 100;              # output training log at regular steps
$saveInterval = 10000;            # save model at regular steps


# Directories & Commands ===============
# project directories
$prjdir = '/home/airenas/projects/hts-scripts/demo/hts-lt';

# Perl
$PERL = '/usr/bin/perl';

# Python
$PYTHON = '/usr/bin/python -u -B';

# wc
$WC = '/usr/bin/wc';

# HTS commands
$HCOMPV    = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HCompV';
$HLIST     = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HList';
$HINIT     = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HInit';
$HREST     = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HRest';
$HEREST    = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HERest';
$HHED      = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HHEd';
$HSMMALIGN = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HSMMAlign';
$HMGENS    = '/home/airenas/projects/hts-scripts/bin/HTS-2.3/bin/HMGenS';
$ENGINE    = '/home/airenas/projects/hts-scripts/bin/hts_engine_API-1.10/bin/hts_engine';

# SPTK commands
$X2X         = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/x2x';
$FREQT       = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/freqt';
$C2ACR       = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/c2acr';
$VOPR        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/vopr';
$VSUM        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/vsum';
$MC2B        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/mc2b';
$SOPR        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/sopr';
$B2MC        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/b2mc';
$EXCITE      = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/excite';
$LSP2LPC     = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/lsp2lpc';
$MGC2MGC     = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/mgc2mgc';
$MGLSADF     = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/mglsadf';
$MERGE       = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/merge';
$BCP         = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/bcp';
$LSPCHECK    = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/lspcheck';
$MGC2SP      = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/mgc2sp';
$BCUT        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/bcut';
$VSTAT       = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/vstat';
$NAN         = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/nan';
$DFS         = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/dfs';
$SWAB        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/swab';
$RAW2WAV     = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/raw2wav';
$MLPG        = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/mlpg';
$INTERPOLATE = '/home/airenas/projects/hts-scripts/bin/SPTK-3.11/bin/interpolate';

# MATLAB & STRAIGHT
$MATLAB   = ': -nodisplay -nosplash -nojvm';
$STRAIGHT = '';


# Switch ================================
$MKENV = 1; # preparing environments
$HCMPV = 1; # computing a global variance
$IN_RE = 1; # initialization & reestimation
$MMMMF = 1; # making a monophone mmf
$ERST0 = 1; # embedded reestimation (monophone)
$MN2FL = 1; # copying monophone mmf to fullcontext one
$ERST1 = 1; # embedded reestimation (fullcontext)
$CXCL1 = 1; # tree-based context clustering
$ERST2 = 1; # embedded reestimation (clustered)
$UNTIE = 1; # untying the parameter sharing structure
$ERST3 = 1; # embedded reestimation (untied)
$CXCL2 = 1; # tree-based context clustering
$ERST4 = 1; # embedded reestimation (re-clustered)
$FALGN = 1; # forced alignment
$MCDGV = 1; # making global variance
$MKUNG = 1; # making unseen models (GV)
$MKUN1 = 1; # making unseen models (speaker independent)
$PGEN1 = 1; # generating speech parameter sequences (speaker independent)
$WGEN1 = 1; # synthesizing waveforms (speaker independent)
$REGTR = 1; # building regression-class trees for adaptation
$ADPT1 = 1; # speaker adaptation (speaker independent)
$PGEN2 = 1; # generating speech parameter sequences (speaker adapted)
$WGEN2 = 1; # synthesizing waveforms (speaker adapted)
$SPKAT = 1; # speaker adaptive training (SAT)
$MKUN2 = 1; # making unseen models (SAT)
$PGEN3 = 1; # generating speech parameter sequences (SAT)
$WGEN3 = 1; # synthesizing waveforms (SAT)
$ADPT2 = 1; # speaker adaptation (SAT)
$PGEN4 = 1; # generate speech parameter sequences (SAT+adaptation)
$WGEN4 = 1; # synthesizing waveforms (SAT+adaptation)
$CONVM = 1; # converting mmfs to the hts_engine file format
$ENGIN = 1; # synthesizing waveforms using hts_engine
$MKDAT = 1; # making training/adaptation data for deep neural network
$TRDNN = 1; # training a deep neural network
$ADPT3 = 1; # speaker adaptation (DNN)
$PGEN5 = 1; # generate speech parameter sequences (DNN+adaptation)
$WGEN5 = 1; # synthesizing waveforms (DNN+adaptation)

1;
