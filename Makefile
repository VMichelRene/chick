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

test:test.byte 
	./test.byte >test.out

clean:
	ocamlbuild -clean
	rm -f test.byte test.out

lib:
	$(OCB) libchick.cma

git: 
	git add .
	git commit -m "maj"
	git push -u orig main

.SUFFIXES:
.SUFFIXES: .ml .byte

.ml.byte:
	$(OCB)  $*.byte

