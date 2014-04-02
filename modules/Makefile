ML=ocamlopt
SRCS=amodule.ml bmodule.ml
HFILES=${wildcard *.mli}
OBJS=${SRCS:.ml=.cmx}
HOBJS=${HFILES:.mli=.cmi}
LIBS=
BINNAME=test

$(BINNAME): $(HOBJS) $(OBJS)
	$(ML) $(LIBS) -o $(BINNAME) $(OBJS)

%.cmx: %.ml
	$(ML) -o $@ -c $<

%.cmi: %.mli
	$(ML) -o $@ -c $<

$(HOBJS): $(HFILES)

$(OBJS): $(SRCS)

clean:
	rm *.cm*
	rm *.o
