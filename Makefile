SHELL:=bash
NAME:=xxx

all:
	$(MAKE) clone
	$(MAKE) build
	$(MAKE) doc

clone:
	for f in `cat repos.txt`; do git clone https://github.com/tomjridge/$$f.git; done
	git clone -b dev https://github.com/tomjridge/tjr_btree.git


build:
	dune build @install


doc:
	dune build @doc

DOCROOT:=_build/default/_doc/_html
copy_doc:
	rm -rf docs/*
	cp -R $(DOCROOT)/* docs

view_doc:
	google-chrome  $(DOCROOT)/index.html


clean:
	dune clean
	rm -rf `cat repos.txt` tjr_btree


with_docker:
	docker build -t $(NAME) .
