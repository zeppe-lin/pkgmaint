.POSIX:

include ../config.mk

MAN1 = finddeps-distmeta.1 finddeps-linked.1 finddisappeared.1 \
       finddisowned.1 findredundantdeps.1 pkgdiff.1 pkglint.1

all:

lint:
	mandoc -Tlint $(MAN1)

install:
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f $(MAN1) $(DESTDIR)$(MANPREFIX)/man1
	cd $(DESTDIR)$(MANPREFIX)/man1 && chmod 0644 $(MAN1)

uninstall:
	cd $(DESTDIR)$(MANPREFIX)/man1 && rm -f $(MAN1)

clean:

.PHONY: all lint install uninstall clean
