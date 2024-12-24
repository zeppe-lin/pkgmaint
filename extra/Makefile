.POSIX:

include ../config.mk

all:

lint:

install:
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	cp -f finddisowned.conf.sample \
		$(DESTDIR)$(SYSCONFDIR)/finddisowned.conf

uninstall:
	cd $(DESTDIR)$(SYSCONFDIR) && rm -f finddisowned.conf

clean:

.PHONY: all lint install uninstall clean
