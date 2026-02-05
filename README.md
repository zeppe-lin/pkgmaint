OVERVIEW
========

This repository contains `pkgmaint`, a collection of scripts for
Zeppe‑Lin, primarily focused on package management and maintenance
tasks.

---

REQUIREMENTS
============

Build-time
----------
  * POSIX `sh(1p)`, `make(1p)`, and "mandatory utilities"
  * `scdoc(1)` to generate manual pages

Runtime
-------
  * POSIX `sh(1p)` and "mandatory utilities"
  * Perl with `YAML::XS(3pm)` module
  * GNU `findutils`
  * GNU `diffutils`
  * GNU `grep`
  * GNU `getopt(1)`
  * `pkgmk`
  * `pkgutils`
  * `pkgman`
  * `curl`

---

INSTALLATION
============

To install:

```sh
# as root
make install
```

Configuration parameters, including installation paths, are defined in
`config.mk`.

---

DOCUMENTATION
=============

Manual pages are provided in the `/man` directory and installed under
the system manual hierarchy.

---

LICENSE
=======

`pkgmaint` is licensed under the
[GNU General Public License v3 or later](https://gnu.org/licenses/gpl.html).

See `COPYING` for license terms and `COPYRIGHT` for notices.
