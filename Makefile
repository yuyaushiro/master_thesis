# TeX Makefile
# Copyright (c) 2016 Tiryoh <tiryoh@gmail.com>
# 
# This Makefile is released under the MIT License.
# https://tiryoh.mit-license.org

.SUFFIXES: .tex .eps .dvi .pdf
.PRECIOUS: %.dvi
.PHONY: all clean refresh

TEXBIN:=uplatex
DVIBIN:=dvipdfmx
BIBBIN:=pbibtex
MENDEXBIN:=mendex
TEXFLAGS:=--kanji=utf8 --shell-escape --halt-on-error --file-line-error --synctex=1
DVIFLAGS:=
BIBFLAGS:=-kanji=utf8
MENDEXFLAGS:=
SOURCE:=$(patsubst main.tex,,$(wildcard *.tex))
# FILENAME:=$(patsubst %.tex,%,$(SOURCE))
FILENAME:=$(patsubst main,,$(patsubst %.tex,%,$(SOURCE)))
TARGET:=$(SOURCE:.tex=.pdf)

all: clean main.pdf

main.pdf: main.dvi
	$(DVIBIN) $(DVIFLAGS) main.dvi

main.dvi: main.tex
	sed -e 's/。/. /g' -e 's/、/, /g' main.tex > tmp.tex
	mkdir -p inc
	sed -e 's/。/. /g' -e 's/、/, /g' titlepage.tex > inc/titlepage.tex
	# sed -e 's/。/. /g' -e 's/、/, /g' summary_ja.tex > inc/summary_ja.tex
	sed -e 's/。/. /g' -e 's/、/, /g' summary.tex > inc/summary.tex
	sed -e 's/。/. /g' -e 's/、/, /g' abstract.tex > inc/abstract.tex
	sed -e 's/。/. /g' -e 's/、/, /g' preface.tex > inc/preface.tex
	sed -e 's/。/. /g' -e 's/、/, /g' introduction.tex > inc/introduction.tex
	sed -e 's/。/. /g' -e 's/、/, /g' mcl.tex > inc/mcl.tex
	sed -e 's/。/. /g' -e 's/、/, /g' pomdp.tex > inc/pomdp.tex
	sed -e 's/。/. /g' -e 's/、/, /g' method.tex > inc/method.tex
	sed -e 's/。/. /g' -e 's/、/, /g' evaluate.tex > inc/evaluate.tex
	sed -e 's/。/. /g' -e 's/、/, /g' conclusion.tex > inc/conclusion.tex
	$(TEXBIN) $(TEXFLAGS) tmp.tex
	$(BIBBIN) $(BIBFLAGS) tmp.aux
	$(MENDEXBIN) $(MENDEXFLAGS) tmp.idx
	$(TEXBIN) $(TEXFLAGS) tmp.tex
	$(TEXBIN) $(TEXFLAGS) tmp.tex
	mv tmp.dvi main.dvi

clean:
	rm -f *.aux *.log *.dvi *.bbl *.blg *.ilg *.idx *.toc *.ind tmp.*
	rm -rf inc
