include config.mk

MAN1 = $(wildcard *.1)
BIN1 = $(MAN1:.1=)

all:

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	for F in ${BIN1}; do \
		sed "s/@VERSION@/${VERSION}/" $$F \
		> ${DESTDIR}${PREFIX}/bin/$$F; \
	done
	cp -f ${MAN1} ${DESTDIR}${MANPREFIX}/man1/
	cd ${DESTDIR}${PREFIX}/bin     && chmod 0755 ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && chmod 0644 ${MAN1}

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MAN1}

install_bashcomp:
	mkdir -p ${DESTDIR}${BASHCOMPDIR}
	for F in ${BIN1}; do \
		ln -sf pkglint ${DESTDIR}${BASHCOMPDIR}/"$$F"; \
	done
	cp -f bash_completion ${DESTDIR}${BASHCOMPDIR}/pkglint

uninstall_bashcomp:
	for F in ${BIN1}; do \
		rm -f ${DESTDIR}${BASHCOMPDIR}/"$$F"; \
	done

clean:
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all install uninstall install_bashcomp uninstall_bashcomp clean dist
