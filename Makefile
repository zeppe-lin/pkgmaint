DESTDIR =
PREFIX  = /usr/local
BINDIR  = $(PREFIX)/bin
MANDIR  = $(PREFIX)/share/man
ETCDIR  = /etc

VERSION = 0.1337

all: finddeps.1 findredundantdeps.1 pkgcheckmissing.1 pkgorphan.1

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

install: all
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      finddeps
	install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 finddeps.1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      findredundantdeps
	install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 findredundantdeps.1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      pkgcheckmissing
	install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 pkgcheckmissing.1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      pkgcheckbuildflags
	install -m 0644 -D -t $(DESTDIR)$(ETCDIR)      pkgcheckbuildflags.conf
	#install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 pkgcheckbuildflags.1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      pkgdisown
	install -m 0644 -D -t $(DESTDIR)$(ETCDIR)      pkgdisown.conf
	#install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 pkgdisown.1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      pkgmk-cflags
	ln -sf /usr/bin/pkgmk-cflags $(DESTDIR)$(BINDIR)/pkgmk-cxxflags
	#install -Dm0644 pkgmk-cflagz       -t $(DESTDIR)$(MANDIR)/man1
	#install -Dm0644 pkgmk-cxxflags     -t $(DESTDIR)$(MANDIR)/man1
	install -m 0755 -D -t $(DESTDIR)$(BINDIR)      pkgorphan
	install -m 0644 -D -t $(DESTDIR)$(MANDIR)/man1 pkgorphan.1

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/finddeps
	rm -f $(DESTDIR)$(MANDIR)/man1/finddeps.1
	rm -f $(DESTDIR)$(BINDIR)/findredundantdeps
	rm -f $(DESTDIR)$(MANDIR)/man1/findredundantdeps.1
	rm -f $(DESTDIR)$(BINDIR)/pkgcheckbuildflags
	rm -f $(DESTDIR)$(ETCDIR)/pkgcheckbuildflags.conf
	#rm -f $(DESTDIR)$(MANDIR)/man1/pkgcheckbuildflags
	rm -f $(DESTDIR)$(BINDIR)/pkgcheckmissing
	rm -f $(DESTDIR)$(MANDIR)/man1/pkgcheckmissing.1
	rm -f $(DESTDIR)$(BINDIR)/pkgdisown
	rm -f $(DESTDIR)$(ETCDIR)/pkgdisown.conf
	#rm -f $(DESTDIR)$(MANDIR)/man1/pkgdisown.1
	rm -f $(DESTDIR)$(BINDIR)/pkgmk-cflags
	unlink $(DESTDIR)$(BINDIR)/pkgmk-cxxflags || :
	rm -f $(DESTDIR)$(BINDIR)/pkgorphan
	rm -f $(DESTDIR)$(MANDIR)/man1/pkgorphan.1

clean:
	rm -f *.1

.PHONY: install uninstall clean

# End of file.
