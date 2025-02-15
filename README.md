OVERVIEW
========

This repository contains pkgmaint, a collection of scripts for
Zeppe-Lin, mainly oriented towards package management and maintaining.


REQUIREMENTS
============

Built time
----------
  * POSIX sh(1p), make(1p) and "mandatory utilities"

Runtime
-------
  * POSIX sh(1p) and "mandatory utilities"
  * YAML::XS(3) perl module and perl itself
  * GNU findutils
  * GNU diffutils
  * GNU grep
  * GNU getopt(1)
  * pkgmk
  * pkgutils
  * pkgman
  * curl


INSTALL
=======

The shell command `make install` should install this package.

See `config.mk` file for configuration parameters.


DOCUMENTATION
=============

Online documentation
--------------------

Manual pages:
- [finddepsdistmeta.1](https://zeppe-lin.github.io/finddepsdistmeta.1.html)
- [finddepslinked.1](https://zeppe-lin.github.io/finddepslinked.1.html)
- [finddisappeared.1](https://zeppe-lin.github.io/finddisappeared.1.html)
- [finddisowned.1](https://zeppe-lin.github.io/finddisowned.1.html)
- [findredundantdeps.1](https://zeppe-lin.github.io/findredundantdeps.1.html)
- [pkgdiff.1](https://zeppe-lin.github.io/pkgdiff.1.html)
- [pkglint.1](https://zeppe-lin.github.io/pkglint.1.html)


LICENSE
=======

pkgmaint is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.

Exceptions
----------
  * finddisappeared was initially developed by Martin Opel by
    unknown license.
