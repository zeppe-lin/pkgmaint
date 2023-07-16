#!/bin/sh

######################################################################
# Informational helpers.                                             #
######################################################################

info() {
	echo "=======> $1"
}

warning() {
	info "WARNING: $1" >&2
}

error() {
	info "ERROR: $1" >&2
}

######################################################################
# Check .footprint files for typical errors.                         #
######################################################################

# Check for SUID/SGID files and directories.
# shellcheck disable=2317
footprint_sugid() {
	awk >&2 '
BEGIN {
	rc=0
}
{
        if ($1 ~ /^[^d]..s....../) {
                print "suid file found: "FILENAME": "$3;
                rc=1;
        } else if ($1 ~ /^[^d].....s.../) {
                print "sgid file found: "FILENAME": "$3;
                rc=1;
        } else if ($1 ~ /^d..s....../) {
                print "suid directory found: "FILENAME": "$3;
                rc=1;
        } else if ($1 ~ /^d.....s.../) {
                print "sgid directory found: "FILENAME": "$3;
                rc=1;
        }
}
END {
	exit(rc)
}'	"$1/.footprint"
}

# Check for world-writeable files and directories.
# shellcheck disable=2317
footprint_wowrite() {
	awk >&2 '
BEGIN {
	rc=0
}
{
        if ($1 ~ /^d.......w[^t]/) {
                print "world writeable directory found: "FILENAME": "$0;
                rc=1;
        } else if ($1 ~ /^-.......w./) {
                print "world writeable file found: "FILENAME": "$0;
                rc=1;
        }
}
END {
	exit(rc)
}'	"$1/.footprint"
}

# Check for invalid directories.
# shellcheck disable=2317
footprint_invalid() {
	awk >&2 '
BEGIN {
	rc=0
}
{
        if ($3 ~ /^usr\/share\/man\/whatis$/) {
                # do nothing
                # skip manpages database
                1;
        } else if ($3 ~ /^usr\/man\//                   \
                || $3 ~ /^usr\/local\//                 \
                || $3 ~ /^usr\/share\/locale\//         \
                || $3 ~ /^usr\/share\/doc\//            \
                || $3 ~ /^usr\/info\//                  \
                || $3 ~ /^usr\/share\/info\//           \
                || $3 ~ /^usr\/libexec\//               \
                || $3 ~ /^usr\/man\/\.\.\//             \
                || $3 ~ /^usr\/share\/man\/\.\.\//      \
                ) {
                print "invalid directory found: "FILENAME": "$3;
                rc=1;
        } else if ($3 ~ /^usr\/share\/man\/[^\/]+$/) {
                print "invalid man location found: "FILENAME": "$3;
                rc=1;
        }
}
END {
	exit(rc)
}'	"$1/.footprint"
}

# Check for junk files.
# shellcheck disable=2317
footprint_junk() {
	awk >&2 '
BEGIN {
	rc=0
}
{
        if ($3 ~ /\/.*\/perllocal\.pod$/     \
	||  $3 ~ /\/perl5\/.*\/\.packlist$/  \
	||  $3 ~ /\/perl5\/.*\/[^\/]+\.bs$/) {
                print "junk file found: "FILENAME": "$3;
                rc=1;
        }
 
        # ignore case
        IGNORECASE = 1;
 
        if ($3 ~ /^usr\/share\/terminfo\/n\/news$$/) {
                # nothing to do
                # skip ncurses terminfo file
                1;
        } else if ($3 ~ /\/AUTHORS$/                                  \
		|| $3 ~ /\/BUGS$/                                     \
		|| $3 ~ /\/COPYING$/                                  \
		|| $3 ~ /\/CHANGELOG$/                                \
		||($3 ~ /\/INSTALL$$/ && $3 !~ /^usr\/bin\/install$/) \
		|| $3 ~ /\/NEWS$/                                     \
		|| $3 ~ /\/README$/                                   \
		|| $3 ~ /\/README.TXT$/                               \
		|| $3 ~ /\/README.md$/                                \
		|| $3 ~ /\/THANKS$/                                   \
		|| $3 ~ /\/TODO$/) {
                print "junk file found: "FILENAME": "$3;
                rc=1;
        }
}
END {
	exit(rc)
}'	"$1/.footprint"
}

######################################################################
# Other checks.                                                      #
######################################################################

# Grep all URLs from Pkgfile and README files.
# shellcheck disable=2317
grep_urls() {
	if [ -r "$1/README" ]; then
		grep -PHio "https?://[^\"\\'> ]+" "$1/README"
	fi
	if [ -r "$1/Pkgfile" ]; then
		grep -PHio "URL:\s*\K(https?://[^\"\\'> ]+)" "$1/Pkgfile"
		(
		. "$1/Pkgfile"
		# Intentional (source slurped from Pkgfile).
		# shellcheck disable=2154
		for __URL in ${source}; do
			case $__URL in
			http://* | https://* ) echo "$1/Pkgfile:$__URL" ;;
			esac
		done
		)
	fi
}

# Check for dead links.
# shellcheck disable=2317
dead_links() {
	__RC1=0
	for __LINE in $(grep_urls "$1"); do
		unset -v __URL __HTTPCODE
		__URL=${__LINE##"$1/Pkgfile:"}
		__URL=${__URL##"$1/README:"}
		# Intentional word splitting.
		# shellcheck disable=2086
		__HTTPCODE=$(curl $CURL_CMD $CURL_OPTS "$__URL")
		if [ "$__HTTPCODE" -ne 200 ]; then
			echo "dead link found: [$__HTTPCODE] $__LINE"
			__RC1=1
		fi
	done
	return "$__RC1"
}

######################################################################

print_help() {
	cat <<EOF
Usage: pkglint [OPTION...] [PKGSRCDIR...]
Detect common mistakes and stylistic issues in pkgsrc package definitions.

  -d, --dead-links       check for dead links
  -i, --invalid          check for invalid directories
  -j, --junk             check for junk files
  -s, --suid-sgid        check for SUID/SGID files and directories
  -w, --world-writeable  check for world-writeable files and directories
  -v, --version          print version and exit
  -h, --help             print help and exit
EOF
}

print_version() {
	echo "${0##*/} (pkgmaint) @VERSION@"
}

parse_options() {
	eval set -- "$(getopt -a -l "$LONGOPTS" -o "$SHORTOPTS" -- "$@")"
	while true; do
		case $1 in
		-d|--dead-links)       CHECK="$CHECK dead_links"        ;;
		-i|--invalid)          CHECK="$CHECK footprint_invalid" ;;
		-j|--junk)             CHECK="$CHECK footprint_junk"    ;;
		-s|--suid-sgid)        CHECK="$CHECK footprint_sugid"   ;;
		-w|--world-writeable)  CHECK="$CHECK footprint_wowrite" ;;
		-v|--version)          print_version ; exit 0           ;;
		-h|--help)             print_help    ; exit 0           ;;
		--)                    shift         ; break            ;;
		esac
		shift
	done
	PKGSRCDIRS=${*:-$PWD}
}

main() {
	parse_options "$@"

	__RC0=0
	for __PKGSRCDIR in $PKGSRCDIRS; do
		if [ ! -d "$__PKGSRCDIR" ]; then
			warning "missing '$__PKGSRCDIR': skip directory"
			__RC0=1
			continue
		fi

		for __FILE in Pkgfile .footprint .md5sum; do
			if [ ! -f "$__PKGSRCDIR/$__FILE" ]; then
				error "missing '$__PKGSRCDIR/$__FILE': skip check"
				__RC0=1
				continue 2
			fi
		done

		for __CHK in $CHECK; do
			$__CHK "$__PKGSRCDIR" || __RC0=1
		done
	done

	exit "$__RC0"
}

######################################################################

# Globals.
export LC_ALL=POSIX
LONGOPTS="dead-links,follow-redirects,invalid,junk,suid-sgid,world-writeable,version,help"
SHORTOPTS="dfijswvh"
CURL_CMD="-L -I -f --retry 3 --retry-delay 3 -o /dev/null -sw %{http_code}"
CURL_OPTS=
CHECK=
PKGSRCDIRS=

main "$@"

# vim: cc=72:tw=70
# End of file.