include config.mk

MAN1 = $(wildcard *.1)
BIN1 = $(MAN1:.1=)

all:

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	for B in ${BIN1}; do sed "s/@VERSION@/${VERSION}/" $$B > \
		${DESTDIR}${PREFIX}/bin/$$B; done
	for M in ${MAN1}; do sed "s/@VERSION@/${VERSION}/" $$M > \
		${DESTDIR}${MANPREFIX}/man1/$$M; done
	cd ${DESTDIR}${PREFIX}/bin     && chmod 0755 ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && chmod 0644 ${MAN1}

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MAN1}

clean:
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all install uninstall clean dist
