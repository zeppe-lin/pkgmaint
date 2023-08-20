OVERVIEW
--------
This directory contains pkgmaint, a collection of scripts for
Zeppe-Lin, mainly oriented towards package management and maintaining.


REQUIREMENTS
------------
**Built time**:
- POSIX sh(1p) and "mandatory utilities"
- GNU make(1)
- pod2man(1pm) to build man pages

**Runtime**:
- POSIX sh(1p) and "mandatory utilities"
- YAML::XS perl module and perl itself
- GNU findutils
- GNU diffutils
- pkgmk
- pkgutils
- pkgman
- curl


INSTALL
-------
The shell commands `make && make install` should build and install
this package.


LICENSE
-------
pkgmaint is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.

**!!!EXCEPTIONS!!!**
- `finddisappeared.in` was initially developed by Martin Opel by unknown
  license.
