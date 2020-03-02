#########################################################################################
in_dir=../demo/hts-w02/data/lf0
out_dir=../demo/hts-w02/data/lf0n
py_dir=../src/py
hz_avg=175

#########################################################################################
in_files=$(shell find $(in_dir)/ -type f -name *.lf0)
out_files=$(patsubst $(in_dir)%, $(out_dir)%, $(in_files))
#########################################################################################

$(out_dir):
	mkdir $(out_dir)
#########################################################################################
$(out_dir)/names: | $(out_dir)
	find $(in_dir)/ -type f -name '*.lf0' | sed -e 's/_[0-9]*.lf0//g' | sort | uniq > $(out_dir)/names
########################################################################################
$(out_dir)/avg.done: $(out_dir)/names
	cat $(out_dir)/names | xargs -n1 -I {} sh -c 'echo {}; cat {}*.lf0 | python $(py_dir)/b2t.py | \
		python $(py_dir)/exp.py | python $(py_dir)/to.cnt.py | \
		python $(py_dir)/avg.py > $(out_dir)/$$(basename {}).avg ; cat $(out_dir)/$$(basename {}).avg'
	touch $(out_dir)/avg.done
calc_avg: $(out_dir)/avg.done
#########################################################################################
$(out_dir)/%.lf0: $(out_dir)/avg.done
	@export expected=$$(echo $(hz_avg) | python $(py_dir)/to.cnt.py); \
	basef=$$(echo $* | sed -e 's/_[0-9]*.$$//g' | sed -e 's=^.../==g'); \
	avg=$$(cat $(out_dir)/$${basef}.avg); \
	fix=$$( python -c "print($${expected} - $${avg})" ); \
	echo $@ $${expected} $${avg} $${fix}; \
	oldf=$$(echo $(in_dir)/$*.lf0); \
	mkdir -p `dirname $@`; \
	cat $${oldf} | python $(py_dir)/b2t.py | \
	python $(py_dir)/norm.py -f $${fix} | python $(py_dir)/t2b.py > $@
#########################################################################################
normalize: $(out_files)	
#	echo $(out_files)
#########################################################################################
test_avg: $(out_dir)/names
	cat $(out_dir)/names | xargs -n1 -I {} sh -c '\
	nf=$$(echo {} | sed -e "s=$(in_dir)=$(out_dir)=g"); \
	echo $${nf}; cat $${nf}*.lf0 | python $(py_dir)/b2t.py | \
		python $(py_dir)/exp.py | python $(py_dir)/to.cnt.py | \
		python $(py_dir)/avg.py | python $(py_dir)/to.hz.py'
#########################################################################################
init_py: 
	conda activate hts

build: $(out_dir)/names

clean: 
	rm -rf $(out_dir)
