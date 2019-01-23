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


view_doc:
	google-chrome  _build/default/_doc/_html/index.html


clean:
	dune clean
	rm -rf `cat repos.txt` tjr_btree


with_docker:
	docker build -t $(NAME) .
