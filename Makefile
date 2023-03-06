.POSIX:

include config.mk

PROGS = $(patsubst %.in,%,$(wildcard *.in))
MANS = $(patsubst %.pod,%,$(wildcard *.pod))

all: ${PROGS} ${MANS}

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r "pkgmaint ${VERSION}" -c ' ' \
		-n $(basename $@) \
		-s $(subst .,,$(suffix $@)) $< > $@

check:
	@echo "=======> Check PODs for errors"
	@podchecker *.pod
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.* \
	 | xargs -P10 -I{} curl -o /dev/null -sw "[%{http_code}] %{url}\n" '{}' \
	 | sort -u

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f ${PROGS} ${DESTDIR}${PREFIX}/bin
	cp -f ${MANS}  ${DESTDIR}${MANPREFIX}/man1
	cd ${DESTDIR}${PREFIX}/bin     && chmod 0755 ${PROGS}
	cd ${DESTDIR}${MANPREFIX}/man1 && chmod 0644 ${MANS}

uninstall:
	cd ${DESTDIR}${PREFIX}/bin     && rm -f ${PROGS}
	cd ${DESTDIR}${MANPREFIX}/man1 && rm -f ${MANS}

clean:
	rm -f ${PROGS} ${MANS}

.PHONY: all check install uninstall clean
