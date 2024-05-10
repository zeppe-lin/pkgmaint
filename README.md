OVERVIEW
========

This directory contains pkgmaint, a collection of scripts for Zeppe-Lin, mainly
oriented towards package management and maintaining.


REQUIREMENTS
============

Built time
----------
  * POSIX sh(1p) and "mandatory utilities"
  * GNU make(1)

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

The shell command `make install` should install this package.  The command
`make install_bashcomp` should install bash completion scripts.

See `config.mk` file for configuration parameters.


LICENSE
=======

pkgmaint is licensed through the GNU General Public License v3 or later
<https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.

Exceptions
----------
  * `finddisappeared` was initially developed by Martin Opel by unknown license.
