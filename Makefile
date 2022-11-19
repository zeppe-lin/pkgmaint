# pkgmaint version
VERSION = 0.1

# paths
PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man
ETCDIR = ${PREFIX}/etc

###
PROGS  = $(patsubst %.in,%,$(wildcard *.in))
MANS   = $(patsubst %.pod,%,$(wildcard *.pod))

all: ${PROGS} ${MANS}

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' -n $(basename $@) \
		-s $(subst .,,$(suffix $@)) $< > $@

install: all
	install -m 0755 -Dt ${DESTDIR}${BINDIR}/ ${PROGS}
	install -m 0644 -Dt ${DESTDIR}${MANDIR}/man1/ ${MANS}
	install -m 0644 -Dt ${DESTDIR}${ETCDIR}/ finddisowned.conf

uninstall:
	cd ${DESTDIR}${BINDIR}/       && rm -f ${PROGS}
	cd ${DESTDIR}${MANDIR}/man1/  && rm -f ${MANS}
	rm -f ${DESTDIR}${ETCDIR}/finddisowned.conf

clean:
	rm -f ${PROGS} ${MANS}

.PHONY: all install uninstall clean
