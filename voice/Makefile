-include $(cfg)

hhed=../bin/HTS-2.3/bin/HHEd

$(voice_dir):
	mkdir $(voice_dir)	

############################################
prepare_lf0_hed: | $(voice_dir)
	echo 'TR 2' > $(voice_dir)/cnv_lf0.hed
	if [ -n "$(lf0_adapt)" ]; then \
      echo 'AX "$(lf0_train_dir)/models/ver1/cmp/$(lf0_adapt)"' >> $(voice_dir)/cnv_lf0.hed; \
    fi 
	echo 'LT "$(lf0_train_dir)/trees/ver1/cmp/lf0.inf.untied"' >> $(voice_dir)/cnv_lf0.hed
	echo 'CT "$(lf0_train_dir)/trees/ver1/cmp"' >> $(voice_dir)/cnv_lf0.hed
	echo 'CM "$(lf0_train_dir)/models/ver1/cmp"' >> $(voice_dir)/cnv_lf0.hed

hhed_lf0: prepare_lf0_hed | $(voice_dir)
	$(hhed) -A -B -C $(lf0_train_dir)/configs/ver1/trn.cnf -D -T 1 -p -i \
		-H $(lf0_train_dir)/models/ver1/cmp/$(lf0_model) \
		-H $(lf0_train_dir)/models/ver1/cmp/regTrees/dec.base \
		-H $(lf0_train_dir)/models/ver1/cmp/regTrees/dec.tree \
		$(voice_dir)/cnv_lf0.hed \
		$(lf0_train_dir)/models/ver1/cmp/tiedlist

prepare_lf0: hhed_lf0 $(voice_dir)
	mv $(lf0_train_dir)/trees/ver1/cmp/trees.2  $(voice_dir)/tree-lf0.inf
	mv $(lf0_train_dir)/models/ver1/cmp/pdf.2 $(voice_dir)/lf0.pdf
############################################
prepare_mgc_hed: | $(voice_dir)
	echo 'TR 2' > $(voice_dir)/cnv_mgc.hed
	if [ -n "$(mgc_adapt)" ]; then \
      echo 'AX "$(mgc_train_dir)/models/ver1/cmp/$(mgc_adapt)"' >> $(voice_dir)/cnv_mgc.hed; \
    fi 
	echo 'LT "$(mgc_train_dir)/trees/ver1/cmp/mgc.inf.untied"' >> $(voice_dir)/cnv_mgc.hed
	echo 'CT "$(mgc_train_dir)/trees/ver1/cmp"' >> $(voice_dir)/cnv_mgc.hed
	echo 'CM "$(mgc_train_dir)/models/ver1/cmp"' >> $(voice_dir)/cnv_mgc.hed

hhed_mgc: prepare_mgc_hed | $(voice_dir)
	$(hhed) -A -B -C $(mgc_train_dir)/configs/ver1/trn.cnf -D -T 1 -p -i \
		-H $(mgc_train_dir)/models/ver1/cmp/$(mgc_model) \
		-H $(mgc_train_dir)/models/ver1/cmp/regTrees/dec.base \
		-H $(mgc_train_dir)/models/ver1/cmp/regTrees/dec.tree \
		$(voice_dir)/cnv_mgc.hed \
		$(mgc_train_dir)/models/ver1/cmp/tiedlist
prepare_mgc: hhed_mgc $(voice_dir)
	mv $(mgc_train_dir)/trees/ver1/cmp/trees.1  $(voice_dir)/tree-mgc.inf
	mv $(mgc_train_dir)/models/ver1/cmp/pdf.1 $(voice_dir)/mgc.pdf
############################################
prepare_dur_hed: | $(voice_dir)
	echo 'TR 2' > $(voice_dir)/dur.hed
	if [ -n "$(dur_adapt)" ]; then \
      echo 'AX "$(dur_train_dir)/models/ver1/dur/$(dur_adapt)"' >> $(voice_dir)/dur.hed; \
    fi 
	echo 'LT "$(dur_train_dir)/trees/ver1/dur/dur.inf.untied"' >> $(voice_dir)/dur.hed
	echo 'CT "$(dur_train_dir)/trees/ver1/dur"' >> $(voice_dir)/dur.hed
	echo 'CM "$(dur_train_dir)/models/ver1/dur"' >> $(voice_dir)/dur.hed

hhed_dur: prepare_dur_hed | $(voice_dir)
	$(hhed) -A -B -C $(mgc_train_dir)/configs/ver1/trn.cnf -D -T 1 -p -i \
		-H $(dur_train_dir)/models/ver1/dur/$(dur_model) \
		-H $(dur_train_dir)/models/ver1/dur/regTrees/dec.base \
		-H $(dur_train_dir)/models/ver1/dur/regTrees/dec.tree \
		$(voice_dir)/dur.hed \
		$(dur_train_dir)/models/ver1/dur/tiedlist

prepare_dur: hhed_dur $(voice_dir)
	mv $(dur_train_dir)/trees/ver1/dur/trees.1  $(voice_dir)/tree-dur.inf
	mv $(dur_train_dir)/models/ver1/dur/pdf.1 $(voice_dir)/dur.pdf
############################################

############################################
cp_orig: $(voice_dir)
	cp -rf $(original_train_dir)/voices/ver1/* $(voice_dir)/
############################################
build_voice:
	perl prepareHTSVoice.pl $(voice_dir) $(original_train_dir)
############################################
all: clean cp_orig prepare_lf0 prepare_mgc prepare_dur build_voice	 
############################################
copy_to_orig:
	cp $(voice_dir)/*.htsvoice $(original_train_dir)/voices/ver1/
############################################
clean: 
	rm -rf $(voice_dir)
############################################
PHONY: prepare_lf0_hed
