.POSIX:

include ../config.mk

all:

install:
	mkdir -p $(DESTDIR)$(BASHCOMPDIR)
	cp -f bash_completion $(DESTDIR)$(BASHCOMPDIR)/pkglint
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddeps-distmeta
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddeps-linked
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddisappeared
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddisowned
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/findredundantdeps
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/pkgdiff

uninstall:
	cd $(DESTDIR)$(BASHCOMPDIR) && \
	rm -f pkglint finddeps-distmeta finddeps-linked \
		finddisappeared finddisowned findredundantdeps pkgdiff

clean:

.PHONY: all install uninstall clean
