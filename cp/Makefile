target_dir=avaiciunas@agpu:~/gfs/hts-scripts
local_target_dir=../agpu/


mkCopy: 
	rsync -P ../Makefile $(target_dir)/
	rsync -P ../Makefile.options $(target_dir)/

dwnCopy:
	rsync -r -P ../downloads_manual $(target_dir)/

srcCopy:
	rsync -r -P ../src $(target_dir)/

demoCopy:
	rsync -r -P ../HTS-demo_CMU-ARCTIC-ADAPT.tar.bz2 $(target_dir)/

hts-w-copy:
	rsync -r -P /home/airenas/hdd/prozodija/demo/sabina-02 $(target_dir)/demo

hts-a-Copy:
	rsync -r -P ../demo/hts-all01 $(target_dir)/demo

cfg-copy:
	rsync -P *cfg $(target_dir)

$(local_target_dir)/hts-w01:
	mkdir -p $(local_target_dir)/hts-w01

genGet: | $(local_target_dir)/hts-w04
	rsync -r -P $(target_dir)/demo/hts-w04/configs $(local_target_dir)/hts-w04
	rsync -r -P $(target_dir)/demo/hts-w04/gen $(local_target_dir)/hts-w04
	rsync -r -P $(target_dir)/demo/hts-w04/models $(local_target_dir)/hts-w04
	rsync -r -P $(target_dir)/demo/hts-w04/trees $(local_target_dir)/hts-w04

genGet2: | $(local_target_dir)/hts-w01
	rsync -r -P $(target_dir)/demo/hts-w01/gen $(local_target_dir)/hts-w01
	rsync -r -P $(target_dir)/demo/hts-w01/configs $(local_target_dir)/hts-w01
	rsync -r -P $(target_dir)/demo/hts-w01/models $(local_target_dir)/hts-w01
	rsync -r -P $(target_dir)/demo/hts-w01/trees $(local_target_dir)/hts-w01
	
.PHONY: mkCopy dwnCopy
