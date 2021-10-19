OCB_FLAGS = -pkgs zarith \
-I Outils \
-I Struct \
-I Parser/P1 \
-I Parser/P2 \
-I Parser/P3 \
-I Parser/P4 

OCB       = ocamlbuild   $(OCB_FLAGS)

test: test.byte 
	test.byte >test.out

clean:
	ocamlbuild -clean
	rm -f test.byte test.out

install:

git: 
	git add .
	git commit -m "maj"
	git push -u orig main

.SUFFIXES:
.SUFFIXES: .ml .byte

.ml.byte:
	$(OCB)  $*.byte

