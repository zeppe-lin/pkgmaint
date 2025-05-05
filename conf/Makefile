.POSIX:

include ../config.mk

all:

install:
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	cp -f finddisowned.conf $(DESTDIR)$(SYSCONFDIR)/

uninstall:
	rm -f $(DESTDIR)$(SYSCONFDIR)/finddisowned.conf

clean:

.PHONY: all install uninstall clean
