.POSIX:

include ../config.mk

all:

lint:
	shellcheck -s bash bash_completion

install:
	mkdir -p $(DESTDIR)$(BASHCOMPDIR)
	cp -f bash_completion $(DESTDIR)$(BASHCOMPDIR)/pkglint
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddepsdistmeta
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddepslinked
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddisappeared
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/finddisowned
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/findredundantdeps
	ln -sf pkglint $(DESTDIR)$(BASHCOMPDIR)/pkgdiff

uninstall:
	cd $(DESTDIR)$(BASHCOMPDIR) && \
	rm -f pkglint finddepsdistmeta finddepslinked \
		finddisappeared finddisowned findredundantdeps pkgdiff

clean:

.PHONY: all lint install uninstall clean
