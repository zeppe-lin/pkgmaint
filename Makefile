.POSIX:

include config.mk

SUBDIRS = completion conf man src

all install uninstall clean:
	for subdir in $(SUBDIRS); do (cd $$subdir; $(MAKE) $@); done

release:
	git tag -a v$(VERSION) -m v$(VERSION)

.PHONY: all install uninstall clean release
