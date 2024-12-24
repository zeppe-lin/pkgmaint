.POSIX:

include ../config.mk

all:

install:
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	cp -f finddisowned.conf.sample \
		$(DESTDIR)$(SYSCONFDIR)/finddisowned.conf

uninstall:
	cd $(DESTDIR)$(SYSCONFDIR) && rm -f finddisowned.conf

clean:

.PHONY: all install uninstall clean
