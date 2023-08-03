# Makefile.lint is the automated checking of pkgmaint project
# for various programmatic and stylistic errors.

all: deadlinks podchecker shellcheck longlines

deadlinks:
	@echo "=======> Check for deadlinks"
	@grep -EIihor "https?://[^\"\\'> ]+" --exclude-dir=.git*  \
		| grep -Ev 'https?://\*'                          \
		| xargs -P10 -r -I{} curl -I -o/dev/null          \
		  -sw "[%{http_code}] %{url}\n" '{}'              \
		| grep -v '\[200\]'                               \
		| sort -u

podchecker:
	@echo "=======> Check PODs for syntax errors"
	@podchecker *.pod >/dev/null

shellcheck:
	@echo "=======> Check shell scripts for syntax errors"
	@grep -m1 -Irl '^#\s*!/bin/sh' --exclude-dir=.git* \
		| xargs -L10 -r shellcheck -s sh

longlines:
	@echo "=======> Check for long lines"
	@! grep -PIrn '^.{81,}$$' --exclude-dir=.git*

.PHONY: all deadlinks podchecker shellcheck longlines
