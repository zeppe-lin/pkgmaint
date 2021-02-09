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
	install -Dm0755 finddeps            -t $(DESTDIR)$(BINDIR)
	install -Dm0644 finddeps.1          -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 findredundantdeps   -t $(DESTDIR)$(BINDIR)
	install -Dm0644 findredundantdeps.1 -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 pkgcheckmissing     -t $(DESTDIR)$(BINDIR)
	install -Dm0644 pkgcheckmissing.1   -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 pkgcheckbuildflags  -t $(DESTDIR)$(BINDIR)
	install -Dm0644 pkgcheckbuildflags.conf -t $(DESTDIR)$(ETCDIR)
	#install -Dm0644 pkgcheckbuildflags.1   -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 pkgdisown           -t $(DESTDIR)$(BINDIR)
	install -Dm0644 pkgdisown.conf      -t $(DESTDIR)$(ETCDIR)
	#install -Dm0644 pkgdisown.1        -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 pkgmk-cflags        -t $(DESTDIR)$(BINDIR)
	ln -sf /usr/bin/pkgmk-cflags $(DESTDIR)$(BINDIR)/pkgmk-cxxflags
	#install -Dm0644 pkgmk-cflagz       -t $(DESTDIR)$(MANDIR)/man1
	#install -Dm0644 pkgmk-cxxflags     -t $(DESTDIR)$(MANDIR)/man1
	install -Dm0755 pkgorphan           -t $(DESTDIR)$(BINDIR)
	install -Dm0644 pkgorphan.1         -t $(DESTDIR)$(MANDIR)/man1

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
