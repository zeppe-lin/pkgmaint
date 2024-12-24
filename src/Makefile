.POSIX:

include ../config.mk

BIN1 = finddepsdistmeta finddepslinked finddisappeared \
       finddisowned findredundantdeps pkgdiff pkglint

all: $(BIN1)

lint:
	shellcheck -s sh finddepslinked.in finddisowned.in \
		findredundantdeps.in pkgdiff.in pkglint.in
	perl -c finddisappeared.in finddepsdistmeta.in

$(BIN1):
	sed "s/@VERSION@/$(VERSION)/" $@.in > $@
	chmod 0755 $@

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(BIN1) $(DESTDIR)$(PREFIX)/bin
	cd $(DESTDIR)$(PREFIX)/bin && chmod 0755 $(BIN1)

uninstall:
	cd $(DESTDIR)$(PREFIX)/bin && rm -f $(BIN1)

clean:
	rm -f $(BIN1)

.PHONY: all lint install uninstall clean
