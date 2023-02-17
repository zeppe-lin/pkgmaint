.POSIX:

include config.mk

PROGRAMS = $(patsubst %.in,%,$(wildcard *.in))
MANPAGES = $(patsubst %.pod,%,$(wildcard *.pod))

all: ${PROGRAMS} ${MANPAGES}

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' -n $(basename $@) \
		-s $(subst .,,$(suffix $@)) $< > $@

check:
	@echo "=======> Check PODs for errors"
	@podchecker *.pod
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.* \
	 | xargs -P10 -I{} curl -o /dev/null -sw "[%{http_code}] %{url}\n" '{}' \
	 | sort -u

install: all
	mkdir -p ${DESTDIR}/usr/bin
	mkdir -p ${DESTDIR}/usr/share/man/man1
	cp -f ${PROGRAMS} ${DESTDIR}/usr/bin
	cp -f ${MANPAGES} ${DESTDIR}/usr/share/man/man1
	cd ${DESTDIR}/usr/bin            && chmod 0755 ${PROGRAMS}
	cd ${DESTDIR}/usr/share/man/man1 && chmod 0644 ${MANPAGES}

uninstall:
	cd ${DESTDIR}/usr/bin            && rm -f ${PROGRAMS}
	cd ${DESTDIR}/usr/share/man/man1 && rm -f ${MANPAGES}

clean:
	rm -f ${PROGRAMS} ${MANPAGES}

.PHONY: all check install uninstall clean
