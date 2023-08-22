include config.mk

BIN1 = $(subst .in,,$(wildcard *.in))
MAN1 = $(subst .1.pod,.1,$(wildcard *.pod))

all: ${BIN1} ${MAN1}

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@
	chmod a+x $@

%: %.pod
	pod2man -r "${NAME} ${VERSION}" -c ' ' -n $(basename $@) \
		-s $(subst .,,$(suffix $@)) $< > $@

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f ${BIN1} ${DESTDIR}${PREFIX}/bin
	cp -f ${MAN1} ${DESTDIR}${MANPREFIX}/man1
	cd ${DESTDIR}${PREFIX}/bin     && chmod 0755 ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && chmod 0644 ${MAN1}

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${BIN1}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MAN1}

clean:
	rm -f ${BIN1} ${MAN1}
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all install uninstall clean dist
