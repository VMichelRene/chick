OCB_INC = \
-I Outils \
-I Struct \
-I Parser/P1 \
-I Parser/P2 \
-I Parser/P3 \
-I Parser/P4 \
-I Parser/Parser2 

OCB_FLAGS = -use-ocamlfind -pkgs zarith $(OCB_INC)

OCB       = ocamlbuild   $(OCB_FLAGS)

FILE_INSTALL = \
_build/chick.cma \
_build/Outils/outils.cmi \
_build/Parser/P1/lexerP1.cmi \
_build/Parser/P1/parserP1.cmi \
_build/Parser/P1/parserTypeP1.cmi \
_build/Parser/P2/lexerP2.cmi \
_build/Parser/P2/parserP2.cmi \
_build/Parser/P2/parserTypeP2.cmi \
_build/Parser/P3/lexerP3.cmi \
_build/Parser/P3/parserP3.cmi \
_build/Parser/P3/parserTypeP3.cmi \
_build/Parser/P4/lexerP4.cmi \
_build/Parser/P4/parserP4.cmi \
_build/Parser/P4/parserTypeP4.cmi \
_build/Parser/Parser2/lexer2.cmi \
_build/Parser/Parser2/parser2.cmi \
_build/Parser/Parser2/parserType2.cmi \
_build/Struct/anneau.cmi \
_build/Struct/e.cmi \
_build/Struct/ens.cmi \
_build/Struct/l.cmi \
_build/Struct/magma_commutatif.cmi \
_build/Struct/magma_commutatif_re_equiv.cmi \
_build/Struct/magma.cmi \
_build/Struct/r.cmi 

FILE_CMA = \
chick.cma 

FILE_CMI = \
outils.cmi \
lexerP1.cmi \
parserP1.cmi \
parserTypeP1.cmi \
lexerP2.cmi \
parserP2.cmi \
parserTypeP2.cmi \
lexerP3.cmi \
parserP3.cmi \
parserTypeP3.cmi \
lexerP4.cmi \
parserP4.cmi \
parserTypeP4.cmi \
lexer2.cmi \
parser2.cmi \
parserType2.cmi \
anneau.cmi \
e.cmi \
ens.cmi \
l.cmi \
magma_commutatif.cmi \
magma_commutatif_re_equiv.cmi \
magma.cmi \
r.cmi 

test:test.byte 
	./test.byte >test.out

clean:
	ocamlbuild -clean
	rm -f test.byte test.out
	(cd Test;rm -f $(FILE_CMI) $(FILE_CMA))
lib:
	$(OCB) $(FILE_CMI)
	$(OCB) $(FILE_CMA)

install:
	cp $(FILE_INSTALL)  Test

git: 
	git add .
	git commit -m "maj"
	git push -u orig main

.SUFFIXES:
.SUFFIXES: .ml .byte

.ml.byte:
	$(OCB)  $*.byte

