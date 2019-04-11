SHELL:=bash
NAME:=xxx
DUNE:=dune

all:
	$(MAKE) clone
	$(MAKE) build
	$(MAKE) docs

clone:
	for f in `cat repos.txt`; do git clone https://github.com/tomjridge/$$f.git; done
	cd tjr_btree && git checkout dev

# git clone -b dev https://github.com/tomjridge/tjr_btree.git


SUBDIRS:=tjr_lib tjr_monad tjr_profile tjr_fs_shared isa_btree tjr_btree tjr_lru_cache tjr_mem_queue tjr_net tjr_pcache tjr_kv
build:
	for f in $(SUBDIRS); do make -C $$f clean && make -C $$f build && make -C $$f install; done
#	$(DUNE) build @install


SRC:=_build/default/_doc/_html
DST:=docs
docs: FORCE
	$(DUNE) build @doc
	rm -rf $(DST)/*
	cp -R $(SRC)/* $(DST)


view_doc:
	google-chrome  $(DOCROOT)/index.html


clean:
	$(DUNE) clean
	rm -rf `cat repos.txt` tjr_btree


with_docker:
	docker build -t $(NAME) .
