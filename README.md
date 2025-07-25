OVERVIEW
========

This repository contains `pkgmaint`, a collection of scripts for
Zeppe-Lin, mainly oriented towards package management and maintaining.


REQUIREMENTS
============

Built time
----------
  * POSIX `sh(1p)`, `make(1p)` and "mandatory utilities"
  * `scdoc(1)` to build manual pages

Runtime
-------
  * POSIX `sh(1p)` and "mandatory utilities"
  * `YAML::XS(3)` perl module and perl itself
  * GNU `findutils`
  * GNU `diffutils`
  * GNU `grep`
  * GNU `getopt(1)`
  * `pkgmk`
  * `pkgutils`
  * `pkgman`
  * `curl`


INSTALL
=======

To install this package, run:

    make install

See `config.mk` file for configuration parameters.


DOCUMENTATION
=============

See `/man` directory for manual pages.


LICENSE
=======

`pkgmaint` is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.
