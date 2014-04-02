FIND=ocamlfind
OCAML=ocamlopt
COMMON=socks.ml
REQS=unix

.PHONY:clean

server: $(COMMON) server.ml
	$(FIND) $(OCAML) -o $@ -linkpkg \
	-package $(REQS)                \
	$+

thread: $(COMMON) tserver.ml
	$(FIND) $(OCAML) -o $@ -linkpkg -thread \
	-package $(REQS),core,threads        \
	$+

async: $(COMMON) aserver.ml
	$(FIND) $(OCAML) -o $@ -linkpkg -thread \
	-package $(REQS),core,async             \
	$+

clean:
	rm server;
