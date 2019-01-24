FROM ocaml/opam2-staging

# various apt pacakges that may or may not be needed
RUN sudo apt-get install -y git make
RUN sudo apt-get install -y curl
RUN sudo apt-get install -y gcc
RUN sudo apt-get install -y bzip2
RUN sudo apt-get install -y wget
RUN sudo apt-get install -y sudo
RUN sudo apt-get install -y unzip m4

# update opam-repository
RUN cd /home/opam/opam-repository && git pull --quiet
RUN opam update
RUN opam install -y dune
RUN opam install -y bos core dune extlib extunix fileutils lwt num ocamlfind omd ppx_bin_prot ppx_deriving_yojson yojson odoc # ocamlfuse
COPY Makefile repos.txt /home/opam/tmp/
# RUN sudo chmod -R ugo+r /home/opam/tmp/*
RUN sudo chown -R opam:opam /home/opam/tmp
RUN cd /home/opam/tmp && ls -al *
RUN eval $(opam env) && make -C /home/opam/tmp

