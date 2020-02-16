-include Makefile.options


dwn_dir=downloads
dwn_m_dir=downloads_manual
tools_dir=${CURDIR}/tools
bin_dir=${CURDIR}/bin

sptk=SPTK-$(sptk_ver)
festival_speech_tools=speech_tools-$(festival_ver)
festival=festival-$(festival_ver)
hts=HTS-$(hts_ver)
htk=HTK-$(htk_ver)
hts_engine=hts_engine_API-$(hts_engine_ver)

$(dwn_dir):
	mkdir $(dwn_dir)
$(tools_dir):
	mkdir $(tools_dir)
$(bin_dir):
	mkdir $(bin_dir)	
#########################################################################################
$(dwn_dir)/$(sptk).tar.gz: | $(dwn_dir)
	wget -O $(dwn_dir)/$(sptk).tar.gz http://downloads.sourceforge.net/sp-tk/$(sptk).tar.gz
$(tools_dir)/$(sptk)/done: $(dwn_dir)/$(sptk).tar.gz | $(tools_dir)
	tar xvzf $(dwn_dir)/$(sptk).tar.gz -C $(tools_dir)
	touch $(tools_dir)/$(sptk)/done

$(bin_dir)/$(sptk)/done: $(tools_dir)/$(sptk)/done | $(bin_dir)
	(cd $(tools_dir)/$(sptk) && ./configure --prefix=$(bin_dir)/$(sptk))
	$(MAKE) -C $(tools_dir)/$(sptk) 
	$(MAKE) -C $(tools_dir)/$(sptk) install
	touch $(bin_dir)/$(sptk)/done

prepare_sptk: $(bin_dir)/$(sptk)/done
#########################################################################################
$(dwn_dir)/$(festival_speech_tools).tar.gz: | $(dwn_dir)
	wget -O $(dwn_dir)/$(festival_speech_tools).tar.gz http://festvox.org/packed/festival/$(festival_short_ver)/$(festival_speech_tools)-release.tar.gz
$(tools_dir)/speech_tools/extracted: $(dwn_dir)/$(festival_speech_tools).tar.gz | $(tools_dir)
	tar xvzf $(dwn_dir)/$(festival_speech_tools).tar.gz -C $(tools_dir)
	touch $(tools_dir)/speech_tools/extracted
$(tools_dir)/speech_tools/done: $(tools_dir)/speech_tools/extracted | $(bin_dir)
	(cd $(tools_dir)/speech_tools && CC=$(gcc_festival) ./configure)
	$(MAKE) -C $(tools_dir)/speech_tools
	touch $(tools_dir)/speech_tools/done
#########################################################################################
$(dwn_dir)/$(festival).tar.gz: | $(dwn_dir)
	wget -O $(dwn_dir)/$(festival).tar.gz http://festvox.org/packed/festival/$(festival_short_ver)/$(festival)-release.tar.gz

$(tools_dir)/festival/extracted: $(dwn_dir)/$(festival).tar.gz | $(tools_dir)
	tar xvzf $(dwn_dir)/$(festival).tar.gz -C $(tools_dir)
	touch $(tools_dir)/festival/extracted

$(tools_dir)/festival/done: $(tools_dir)/festival/extracted $(tools_dir)/speech_tools/done | $(bin_dir)
	(cd $(tools_dir)/festival && CC=$(gcc_festival) ./configure)
	$(MAKE) -C $(tools_dir)/festival -j 1
	touch $(tools_dir)/festival/done
prepare_festival: $(tools_dir)/festival/done
#########################################################################################
$(dwn_dir)/$(hts).tar.bz2: | $(dwn_dir)
	wget -O $(dwn_dir)/$(hts).tar.bz2 http://hts.sp.nitech.ac.jp/archives/$(hts_ver)/$(hts)_for_HTK-3.4.1.tar.bz2
$(tools_dir)/$(hts):
	mkdir -p $(tools_dir)/$(hts)
$(tools_dir)/$(hts)/hts.done: $(dwn_dir)/$(hts).tar.bz2 | $(tools_dir)/$(hts)
	tar xvjf $(dwn_dir)/$(hts).tar.bz2 -C $(tools_dir)/$(hts)
	touch $(tools_dir)/$(hts)/hts.done
extract_hts: $(tools_dir)/$(hts)/hts.done
#########################################################################################
$(tools_dir)/$(hts)-$(htk)/htk.done: $(dwn_m_dir)/$(htk).tar.gz | $(tools_dir)
	tar xvzf $(dwn_m_dir)/$(htk).tar.gz -C $(tools_dir)
	mv $(tools_dir)/htk $(tools_dir)/$(hts)-$(htk)
	touch $(tools_dir)/$(hts)-$(htk)/htk.done

$(tools_dir)/$(hts)-$(htk)/hdecode.done: $(dwn_m_dir)/HDecode-$(htk_ver).tar.gz  $(tools_dir)/$(hts)-$(htk)/htk.done | $(tools_dir)
	tar xvzf $(dwn_m_dir)/HDecode-$(htk_ver).tar.gz -C $(tools_dir)
	cp -r $(tools_dir)/htk/* $(tools_dir)/$(hts)-$(htk)
	touch $(tools_dir)/$(hts)-$(htk)/hdecode.done

$(tools_dir)/$(hts)-$(htk)/patched: $(tools_dir)/$(hts)-$(htk)/htk.done $(tools_dir)/$(hts)-$(htk)/hdecode.done $(tools_dir)/$(hts)/hts.done
	patch -p1 -d $(tools_dir)/$(hts)-$(htk) < $(tools_dir)/$(hts)/$(hts)_for_HTK-3.4.1.patch
	patch -p1 -d $(tools_dir)/$(hts)-$(htk) < src/patch/doubleQuoteFixForHTS2.3beta.patch
	touch $(tools_dir)/$(hts)-$(htk)/patched

$(bin_dir)/$(hts)/done: $(tools_dir)/$(hts)-$(htk)/patched | $(bin_dir)
	(cd $(tools_dir)/$(hts)-$(htk) && ./configure --prefix=$(bin_dir)/$(hts) --host=linux)
	$(MAKE) -C $(tools_dir)/$(hts)-$(htk)
	$(MAKE) -C $(tools_dir)/$(hts)-$(htk) install
	touch $(bin_dir)/$(hts)/done
prepare_hts: $(bin_dir)/$(hts)/done
#########################################################################################
$(tools_dir)/$(hts_engine)/hts_engine.done: $(dwn_m_dir)/$(hts_engine).tar.gz | $(tools_dir)
	tar xvxf $(dwn_m_dir)/$(hts_engine).tar.gz -C $(tools_dir)
	touch $(tools_dir)/$(hts_engine)/hts_engine.done

$(tools_dir)/$(hts_engine)/patched: $(tools_dir)/$(hts_engine)/hts_engine.done 
	patch -p1 -d $(tools_dir)/$(hts_engine) < src/patch/doubleQuoteFixForHtsEngine1.09.patch
	touch $(tools_dir)/$(hts_engine)/patched

$(bin_dir)/$(hts_engine)/done: $(tools_dir)/$(hts_engine)/patched | $(bin_dir)
	(cd $(tools_dir)/$(hts_engine) && ./configure --prefix=$(bin_dir)/$(hts_engine))
	$(MAKE) -C $(tools_dir)/$(hts_engine)
	$(MAKE) -C $(tools_dir)/$(hts_engine) install
	touch $(bin_dir)/$(hts_engine)/done
prepare_hts_engine: $(bin_dir)/$(hts_engine)/done
#########################################################################################
prepare_all: prepare_hts_engine prepare_hts prepare_festival prepare_sptk
install:
	sudo apt-get install libx11-dev csh libncurses5-dev sox
#########################################################################################
configure_cmu_arctic:
	(cd HTS-demo_CMU-ARCTIC-ADAPT && \
   		./configure --with-fest-search-path=$(tools_dir)/festival/examples \
                 --with-sptk-search-path=$(bin_dir)/$(sptk)/bin \
                 --with-hts-search-path=$(bin_dir)/$(hts)/bin \
                 --with-hts-engine-search-path=$(bin_dir)/$(hts_engine)/bin )

clean:
	rm -rf $(dwn_dir)
	rm -rf $(bin_dir)
	rm -rf $(tools_dir)
