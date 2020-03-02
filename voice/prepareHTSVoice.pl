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

use lib '.';

$| = 1;

if ( @ARGV < 2 ) {
   print "usage: prepareHTSVoice.pl voice_dir original_dir\n";
   exit(0);
}

require( "$ARGV[1]/scripts/Config.pm" );

# load configuration variables
$dir= $ARGV[0];

# model structure
foreach $set (@SET) {
   $vSize{$set}{'total'}   = 0;
   $nstream{$set}{'total'} = 0;
   $nPdfStreams{$set}      = 0;
   foreach $type ( @{ $ref{$set} } ) {
      $vSize{$set}{$type} = $nwin{$type} * $ordr{$type};
      $vSize{$set}{'total'} += $vSize{$set}{$type};
      $nstream{$set}{$type} = $stre{$type} - $strb{$type} + 1;
      $nstream{$set}{'total'} += $nstream{$set}{$type};
      $nPdfStreams{$set}++;
   }
}

# File locations =========================
# data directory
$datdir = "$prjdir/data";

# data location file
$scp{'trn'} = "$datdir/scp/train.cmp.scp";
$scp{'gen'} = "$datdir/scp/gen.lab.scp";
$scp{'adp'} = "$datdir/scp/adapt.cmp.scp";

# model list files
$lst{'mon'} = "$datdir/lists/mono.list";
$lst{'ful'} = "$datdir/lists/full.list";
$lst{'all'} = "$datdir/lists/full_all.list";

# master label files
$mlf{'mon'} = "$datdir/labels/mono.mlf";
$mlf{'ful'} = "$datdir/labels/full.mlf";

# configuration variable files
$cfg{'trn'} = "$prjdir/configs/ver${ver}/trn.cnf";
$cfg{'nvf'} = "$prjdir/configs/ver${ver}/nvf.cnf";
$cfg{'syn'} = "$prjdir/configs/ver${ver}/syn.cnf";
foreach $type (@cmp) {
   $cfg{$type} = "$prjdir/configs/ver${ver}/${type}.cnf";
}
foreach $type (@dur) {
   $cfg{$type} = "$prjdir/configs/ver${ver}/${type}.cnf";
}

# configuration variable files for adaptation
$cfg{'adp'} = "$prjdir/configs/ver${ver}/adp.cnf";
$cfg{'map'} = "$prjdir/configs/ver${ver}/map.cnf";
$cfg{'aln'} = "$prjdir/configs/ver${ver}/aln.cnf";
$cfg{'sat'} = "$prjdir/configs/ver${ver}/sat.cnf";
foreach $set (@SET) {
   $cfg{'dec'}{$set} = "$prjdir/configs/ver${ver}/dec_${set}.cnf";
}

# name of proto type definition file
$prtfile{'cmp'} = "$prjdir/proto/ver${ver}/state-${nState}_stream-$nstream{'cmp'}{'total'}";
foreach $type (@cmp) {
   $prtfile{'cmp'} .= "_${type}-$vSize{'cmp'}{$type}";
}
$prtfile{'cmp'} .= ".prt";

# model files
foreach $set (@SET) {
   $model{$set}   = "$prjdir/models/ver${ver}/${set}";
   $hinit{$set}   = "$model{$set}/HInit";
   $hrest{$set}   = "$model{$set}/HRest";
   $vfloors{$set} = "$model{$set}/vFloors";
   $avermmf{$set} = "$model{$set}/average.mmf";
   $initmmf{$set} = "$model{$set}/init.mmf";
   $monommf{$set} = "$model{$set}/monophone.mmf";
   $fullmmf{$set} = "$model{$set}/fullcontext.mmf";
   $clusmmf{$set} = "$model{$set}/clustered.mmf";
   $untymmf{$set} = "$model{$set}/untied.mmf";
   $reclmmf{$set} = "$model{$set}/re_clustered.mmf";
   $rclammf{$set} = "$model{$set}/re_clustered_all.mmf";
   $spatmmf{$set} = "$model{$set}/re_clustered_sat.mmf";
   $satammf{$set} = "$model{$set}/re_clustered_sat_all.mmf";
   $tiedlst{$set} = "$model{$set}/tiedlist";
}

# statistics files
foreach $set (@SET) {
   $stats{$set} = "$prjdir/stats/ver${ver}/${set}.stats";
}

# model edit files
foreach $set (@SET) {
   $hed{$set} = "$prjdir/edfiles/ver${ver}/${set}";
   $lvf{$set} = "$hed{$set}/lvf.hed";
   $m2f{$set} = "$hed{$set}/m2f.hed";
   $mku{$set} = "$hed{$set}/mku.hed";
   $unt{$set} = "$hed{$set}/unt.hed";
   $upm{$set} = "$hed{$set}/upm.hed";
   foreach $type ( @{ $ref{$set} } ) {
      $cnv{$type} = "$hed{$set}/cnv_$type.hed";
      $cxc{$type} = "$hed{$set}/cxc_$type.hed";
   }
}

# questions about contexts
foreach $set (@SET) {
   foreach $type ( @{ $ref{$set} } ) {
      $qs{$type}     = "$datdir/questions/questions_${qname}.hed";
      $qs_utt{$type} = "$datdir/questions/questions_utt_${qname}.hed";
   }
}

# decision tree files
foreach $set (@SET) {
   $trd{$set} = "${prjdir}/trees/ver${ver}/${set}";
   foreach $type ( @{ $ref{$set} } ) {
      $mdl{$type} = "-m -a $mdlf{$type}" if ( $thr{$type} eq '000' );
      $tre{$type} = "$trd{$set}/${type}.inf";
   }
}

# converted model & tree files for hts_engine
$voice = "$prjdir/voices/ver${ver}";
foreach $set (@SET) {
   foreach $type ( @{ $ref{$set} } ) {
      $trv{$type} = "$voice/tree-${type}.inf";
      $pdf{$type} = "$voice/${type}.pdf";
   }
}
$type       = 'lpf';
$trv{$type} = "$voice/tree-${type}.inf";
$pdf{$type} = "$voice/${type}.pdf";

# window files for parameter generation
$windir = "${datdir}/win";
foreach $type (@cmp) {
   for ( $d = 1 ; $d <= $nwin{$type} ; $d++ ) {
      $win{$type}[ $d - 1 ] = "${type}.win${d}";
   }
}
$type                 = 'lpf';
$d                    = 1;
$win{$type}[ $d - 1 ] = "${type}.win${d}";

# global variance files and directories for parameter generation
$gvdir           = "$prjdir/gv/ver${ver}";
$gvfaldir{'phn'} = "$gvdir/fal/phone";
$gvfaldir{'stt'} = "$gvdir/fal/state";
$gvdatdir        = "$gvdir/dat";
$gvlabdir        = "$gvdir/lab";
$gvmodels        = "$gvdir/models";
$scp{'gv'}       = "$gvdir/gv.scp";
$mlf{'gv'}       = "$gvdir/gv.mlf";
$lst{'gv'}       = "$gvdir/gv.list";
$stats{'gv'}     = "$gvdir/stats/gv.stats";
$prtfile{'gv'}   = "$gvdir/proto/state-1_stream-${nPdfStreams{'cmp'}}";
foreach $type (@cmp) {
   $prtfile{'gv'} .= "_${type}-$ordr{$type}";
}
$prtfile{'gv'} .= ".prt";
$vfloors{'gv'} = "$gvmodels/vFloors";
$avermmf{'gv'} = "$gvmodels/average.mmf";
$fullmmf{'gv'} = "$gvmodels/fullcontext.mmf";
$clusmmf{'gv'} = "$gvmodels/clustered.mmf";
$clsammf{'gv'} = "$gvmodels/clustered_all.mmf";
$tiedlst{'gv'} = "$gvmodels/tiedlist";
$mku{'gv'}     = "$gvdir/edfiles/mku.hed";

foreach $type (@cmp) {
   $gvcnv{$type} = "$gvdir/edfiles/cnv_$type.hed";
   $gvcxc{$type} = "$gvdir/edfiles/cxc_$type.hed";
   $gvmdl{$type} = "-m -a $gvmdlf{$type}" if ( $gvthr{$type} eq '000' );
   $gvtre{$type} = "$gvdir/trees/${type}.inf";
   $gvpdf{$type} = "$voice/gv-${type}.pdf";
   $gvtrv{$type} = "$voice/tree-gv-${type}.inf";
}

# adaptation-related files
foreach $set (@SET) {
   $regtree{$set} = "$model{$set}/regTrees";
   $xforms{$set}  = "$model{$set}/xforms";
   $mapmmf{$set}  = "$model{$set}/mapmmf";
   for $type ( 'reg', 'dec' ) {    # reg -> regression tree, dec -> decision tree
      $red{$set}{$type}   = "$hed{$set}/${type}.hed";
      $rbase{$set}{$type} = "$regtree{$set}/${type}.base";
      $rtree{$set}{$type} = "$regtree{$set}/${type}.tree";
   }
}

# files and directories for neural networks
$dnndir              = "$prjdir/dnn/ver${ver}";
$dnnffidir{'ful'}    = "$dnndir/ffi/full";
$dnnffidir{'gen'}    = "$dnndir/ffi/gen";
$dnnmodels           = "$dnndir/models";
$dnnmodelsdir{'adp'} = "$dnnmodels/adapt";
$scp{'tdn'}          = "$dnndir/train.ffi-ffo.scp";
$scp{'sdn'}          = "$dnndir/gen.ffi.scp";
$scp{'adn'}          = "$dnndir/adapt.ffi-ffo.scp";
$cfg{'tdn'}          = "$prjdir/configs/ver${ver}/trn_dnn.cnf";
$cfg{'sdn'}          = "$prjdir/configs/ver${ver}/syn_dnn.cnf";
$cfg{'adn'}          = "$prjdir/configs/ver${ver}/adp_dnn.cnf";
$qconf               = "$datdir/configs/$qname.conf";

# HTS Commands & Options ========================
$HCompV{'cmp'}    = "$HCOMPV    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -m ";
$HCompV{'gv'}     = "$HCOMPV    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'gv'}  -m ";
$HList            = "$HLIST     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -h -z ";
$HInit            = "$HINIT     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'}                -m 1 -u tmvw     -w $wf ";
$HRest            = "$HREST     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'}                -m 1 -u tmvw     -w $wf ";
$HERest{'mon'}    = "$HEREST    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'mon'} -m 1 -u tmvwdmv  -w $wf -t $beam ";
$HERest{'ful'}    = "$HEREST    -A -B -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'ful'} -m 1 -u tmvwdmv  -w $wf -t $beam -h $spkrPat ";
$HERest{'gv'}     = "$HEREST    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'gv'}  -I $mlf{'gv'}  -m 1 ";
$HERest{'adp'}    = "$HEREST    -A -B -C $cfg{'trn'} -D -T 1 -S $scp{'adp'} -I $mlf{'ful'} -m 1 -u ada      -w $wf -t $beam -h $spkrPat ";
$HERest{'map'}    = "$HEREST    -A -B -C $cfg{'trn'} -D -T 1 -S $scp{'adp'} -I $mlf{'ful'} -m 1 -u pmvwdpmv -w $wf -t $beam -h $spkrPat ";
$HHEd{'trn'}      = "$HHED      -A -B -C $cfg{'trn'} -D -T 1 -p -i ";
$HSMMAlign{'trn'} = "$HSMMALIGN -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'ful'}                  -w 1.0 -t $beam ";
$HSMMAlign{'adp'} = "$HSMMALIGN -A    -C $cfg{'trn'} -D -T 1 -S $scp{'adp'} -I $mlf{'ful'}                  -w 1.0 -t $beam ";
$HMGenS           = "$HMGENS    -A -B -C $cfg{'syn'} -D -T 1 -S $scp{'gen'}                                        -t $beam -h $spkrPat ";

# =============================================================
# ===================== Main Program ==========================
# =============================================================

# fix variables
$stats{'cmp'} =~ s/untied/re-clustered/;

print_time("converting mmfs to the HTS voice format");

$type = $tknd{'adp'};
$mllr = $tran;
$mix  = "SAT+${type}_${mllr}${nAdapt}";

# window coefficients
foreach $type (@cmp) {
   shell("cp $windir/${type}.win* $voice");
}

# gv pdfs
if ($useHmmGV) {
   my $s = 1;
   foreach $type (@cmp) {    # convert hts_engine format
      make_edfile_convert_gv($type);
      shell("$HHEd{'trn'} -H $clusmmf{'gv'} $gvcnv{$type} $lst{'gv'}");
      shell("mv $gvdir/trees.$s $gvtrv{$type}");
      shell("mv $gvdir/pdf.$s $gvpdf{$type}");
      $s++;
   }
}

# make HTS voice
make_htsvoice( $dir, "${dset}_${spkr}" );
print "DONE. Voice is in $dir/${dset}_${spkr}.htsvoice\n";


# sub routines ============================
sub shell($) {
   my ($command) = @_;
   my ($exit);

   $exit = system($command);

   if ( $exit / 256 != 0 ) {
      die "Error in $command\n";
   }
}

sub print_time ($) {
   my ($message) = @_;
   my ($ruler);

   $message .= `date`;

   $ruler = '';
   for ( $i = 0 ; $i <= length($message) + 10 ; $i++ ) {
      $ruler .= '=';
   }

   print "\n$ruler\n";
   print "Start @_ at " . `date`;
   print "$ruler\n\n";
}

# sub routine for generating HTS voice for hts_engine API
sub make_htsvoice($$) {
   my ( $voicedir, $voicename ) = @_;
   my ( $i, $type, $tmp, @coef, $coefSize, $file_index, $s, $e );

   open( HTSVOICE, "> ${voicedir}/${voicename}.htsvoice" );

   # global information
   print HTSVOICE "[GLOBAL]\n";
   print HTSVOICE "HTS_VOICE_VERSION:1.0\n";
   print HTSVOICE "SAMPLING_FREQUENCY:${sr}\n";
   print HTSVOICE "FRAME_PERIOD:${fs}\n";
   print HTSVOICE "NUM_STATES:${nState}\n";
   print HTSVOICE "NUM_STREAMS:" . ( ${ nPdfStreams { 'cmp' } } + 1 ) . "\n";
   print HTSVOICE "STREAM_TYPE:";

   for ( $i = 0 ; $i < @cmp ; $i++ ) {
      if ( $i != 0 ) {
         print HTSVOICE ",";
      }
      $tmp = get_stream_name( $cmp[$i] );
      print HTSVOICE "${tmp}";
   }
   print HTSVOICE ",LPF\n";
   print HTSVOICE "FULLCONTEXT_FORMAT:${fclf}\n";
   print HTSVOICE "FULLCONTEXT_VERSION:${fclv}\n";
   if ( $useHmmGV && $nosilgv && @slnt > 0 ) {
      print HTSVOICE "GV_OFF_CONTEXT:";
      for ( $i = 0 ; $i < @slnt ; $i++ ) {
         if ( $i != 0 ) {
            print HTSVOICE ",";
         }
         print HTSVOICE "\"*-${slnt[$i]}+*\"";
      }
   }
   print HTSVOICE "\n";
   print HTSVOICE "COMMENT:\n";

   # stream information
   print HTSVOICE "[STREAM]\n";
   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      print HTSVOICE "VECTOR_LENGTH[${tmp}]:${ordr{$type}}\n";
   }
   $type     = "lpf";
   $tmp      = get_stream_name($type);
   @coef     = split( '\s', `$PERL $datdir/scripts/makefilter.pl $sr 0` );
   $coefSize = @coef;
   print HTSVOICE "VECTOR_LENGTH[${tmp}]:${coefSize}\n";
   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      print HTSVOICE "IS_MSD[${tmp}]:${msdi{$type}}\n";
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   print HTSVOICE "IS_MSD[${tmp}]:0\n";
   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      print HTSVOICE "NUM_WINDOWS[${tmp}]:${nwin{$type}}\n";
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   print HTSVOICE "NUM_WINDOWS[${tmp}]:1\n";
   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      if ($useHmmGV) {
         print HTSVOICE "USE_GV[${tmp}]:1\n";
      }
      else {
         print HTSVOICE "USE_GV[${tmp}]:0\n";
      }
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   print HTSVOICE "USE_GV[${tmp}]:0\n";
   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      if ( $tmp eq "MCP" ) {
         print HTSVOICE "OPTION[${tmp}]:ALPHA=$fw\n";
      }
      elsif ( $tmp eq "LSP" ) {
         print HTSVOICE "OPTION[${tmp}]:ALPHA=$fw,GAMMA=$gm,LN_GAIN=$lg\n";
      }
      else {
         print HTSVOICE "OPTION[${tmp}]:\n";
      }
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   print HTSVOICE "OPTION[${tmp}]:\n";

   # position
   $file_index = 0;
   print HTSVOICE "[POSITION]\n";
   $file_size = get_file_size("${voicedir}/dur.pdf");
   $s         = $file_index;
   $e         = $file_index + $file_size - 1;
   print HTSVOICE "DURATION_PDF:${s}-${e}\n";
   $file_index += $file_size;
   $file_size = get_file_size("${voicedir}/tree-dur.inf");
   $s         = $file_index;
   $e         = $file_index + $file_size - 1;
   print HTSVOICE "DURATION_TREE:${s}-${e}\n";
   $file_index += $file_size;

   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      print HTSVOICE "STREAM_WIN[${tmp}]:";
      for ( $i = 0 ; $i < $nwin{$type} ; $i++ ) {
         $file_size = get_file_size("${voicedir}/$win{$type}[$i]");
         $s         = $file_index;
         $e         = $file_index + $file_size - 1;
         if ( $i != 0 ) {
            print HTSVOICE ",";
         }
         print HTSVOICE "${s}-${e}";
         $file_index += $file_size;
      }
      print HTSVOICE "\n";
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   print HTSVOICE "STREAM_WIN[${tmp}]:";
   $file_size = get_file_size("$voicedir/$win{$type}[0]");
   $s         = $file_index;
   $e         = $file_index + $file_size - 1;
   print HTSVOICE "${s}-${e}";
   $file_index += $file_size;
   print HTSVOICE "\n";

   foreach $type (@cmp) {
      $tmp       = get_stream_name($type);
      $file_size = get_file_size("${voicedir}/${type}.pdf");
      $s         = $file_index;
      $e         = $file_index + $file_size - 1;
      print HTSVOICE "STREAM_PDF[$tmp]:${s}-${e}\n";
      $file_index += $file_size;
   }
   $type      = "lpf";
   $tmp       = get_stream_name($type);
   $file_size = get_file_size("${voicedir}/${type}.pdf");
   $s         = $file_index;
   $e         = $file_index + $file_size - 1;
   print HTSVOICE "STREAM_PDF[$tmp]:${s}-${e}\n";
   $file_index += $file_size;

   foreach $type (@cmp) {
      $tmp       = get_stream_name($type);
      $file_size = get_file_size("${voicedir}/tree-${type}.inf");
      $s         = $file_index;
      $e         = $file_index + $file_size - 1;
      print HTSVOICE "STREAM_TREE[$tmp]:${s}-${e}\n";
      $file_index += $file_size;
   }
   $type      = "lpf";
   $tmp       = get_stream_name($type);
   $file_size = get_file_size("${voicedir}/tree-${type}.inf");
   $s         = $file_index;
   $e         = $file_index + $file_size - 1;
   print HTSVOICE "STREAM_TREE[$tmp]:${s}-${e}\n";
   $file_index += $file_size;

   if ($useHmmGV) {
      foreach $type (@cmp) {
         $tmp       = get_stream_name($type);
         $file_size = get_file_size("${voicedir}/gv-${type}.pdf");
         $s         = $file_index;
         $e         = $file_index + $file_size - 1;
         print HTSVOICE "GV_PDF[$tmp]:${s}-${e}\n";
         $file_index += $file_size;
      }
   }
   if ( $useHmmGV && $cdgv ) {
      foreach $type (@cmp) {
         $tmp       = get_stream_name($type);
         $file_size = get_file_size("${voicedir}/tree-gv-${type}.inf");
         $s         = $file_index;
         $e         = $file_index + $file_size - 1;
         print HTSVOICE "GV_TREE[$tmp]:${s}-${e}\n";
         $file_index += $file_size;
      }
   }

   # data information
   print HTSVOICE "[DATA]\n";
   open( I, "${voicedir}/dur.pdf" ) || die "Cannot open $!";
   @STAT = stat(I);
   read( I, $DATA, $STAT[7] );
   close(I);
   print "Add: ${voicedir}/dur.pdf\n";
   print HTSVOICE $DATA;
   open( I, "${voicedir}/tree-dur.inf" ) || die "Cannot open $!";
   @STAT = stat(I);
   read( I, $DATA, $STAT[7] );
   close(I);
   print HTSVOICE $DATA;

   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      for ( $i = 0 ; $i < $nwin{$type} ; $i++ ) {
         open( I, "${voicedir}/$win{$type}[$i]" ) || die "Cannot open $!";
         @STAT = stat(I);
         read( I, $DATA, $STAT[7] );
         close(I);
         print "Add: ${voicedir}/$win{$type}[$i]\n";
         print HTSVOICE $DATA;
      }
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   open( I, "${voicedir}/$win{$type}[0]" ) || die "Cannot open $!";
   @STAT = stat(I);
   read( I, $DATA, $STAT[7] );
   close(I);
   print HTSVOICE $DATA;

   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      open( I, "${voicedir}/${type}.pdf" ) || die "Cannot open $!";
      @STAT = stat(I);
      read( I, $DATA, $STAT[7] );
      close(I);
      print "Add: ${voicedir}/${type}.pdf\n";
      print HTSVOICE $DATA;
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   open( I, "${voicedir}/${type}.pdf" ) || die "Cannot open $!";
   @STAT = stat(I);
   read( I, $DATA, $STAT[7] );
   close(I);
   print "Add: ${voicedir}/${type}.pdf\n";
   print HTSVOICE $DATA;

   foreach $type (@cmp) {
      $tmp = get_stream_name($type);
      open( I, "${voicedir}/tree-${type}.inf" ) || die "Cannot open $!";
      @STAT = stat(I);
      read( I, $DATA, $STAT[7] );
      close(I);
      print "Add: ${voicedir}/tree-${type}.inf\n";
      print HTSVOICE $DATA;
   }
   $type = "lpf";
   $tmp  = get_stream_name($type);
   open( I, "${voicedir}/tree-${type}.inf" ) || die "Cannot open $!";
   @STAT = stat(I);
   read( I, $DATA, $STAT[7] );
   close(I);
   print "Add: ${voicedir}/tree-${type}.inf\n";
   print HTSVOICE $DATA;

   if ($useHmmGV) {
      foreach $type (@cmp) {
         $tmp = get_stream_name($type);
         open( I, "${voicedir}/gv-${type}.pdf" ) || die "Cannot open $!";
         @STAT = stat(I);
         read( I, $DATA, $STAT[7] );
         close(I);
         print "Add: ${voicedir}/gv-${type}.pdf\n";
         print HTSVOICE $DATA;
      }
   }
   if ( $useHmmGV && $cdgv ) {
      foreach $type (@cmp) {
         $tmp = get_stream_name($type);
         open( I, "${voicedir}/tree-gv-${type}.inf" ) || die "Cannot open $!";
         @STAT = stat(I);
         read( I, $DATA, $STAT[7] );
         close(I);
         print "Add: ${voicedir}/tree-gv-${type}.inf\n";
         print HTSVOICE $DATA;
      }
   }
   close(HTSVOICE);
}

# sub routine for getting stream name for HTS voice
sub get_stream_name($) {
   my ($from) = @_;
   my ($to);

   if ( $from eq 'mgc' ) {
      if ( $gm == 0 ) {
         $to = "MCP";
      }
      else {
         $to = "LSP";
      }
   }
   else {
      $to = uc $from;
   }

   return $to;
}

# sub routine for getting file size
sub get_file_size($) {
   my ($file) = @_;
   my ($file_size);

   $file_size = `$WC -c < $file`;
   chomp($file_size);

   return $file_size;
}
##################################################################################################
