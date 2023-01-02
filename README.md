ABOUT
-----
This directory contains *pkgmaint*, a collection of scripts for
*Zeppe-Lin*, mainly oriented towards package management and
maintaining.

REQUIREMENTS
------------
Built time:
  * POSIX sh(1p), make(1p) and "mandatory utilities"
  * pod2man(1pm) from perl distribution to build man pages

Runtime:
  * POSIX sh(1p) and "mandatory utilities"
  * YAML::XS perl module and perl itself
  * GNU findutils
  * pkgmk, pkgutils and pkgman distributions

Tests:
  * podchecker(1pm) from perl distribution to check PODs for errors
  * httpx(1) to check URLs for non-200 response code

INSTALL
-------
The shell commands `make && make install` should build and install
this package.

The shell command `make check` should build and start some tests.

LICENSE
-------
*pkgmaint* is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.
Read the *COPYING* file for copying conditions.
Read the *COPYRIGHT* file for copyright notices.

**!!! EXCEPTIONS !!!**
* finddisappeared.in was initially developed by Martin Opel by unknown
  license.


<!-- vim:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->
