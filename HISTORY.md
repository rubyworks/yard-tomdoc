# RELEASE HISTORY

## 0.2.1 | 2011-05-23

There is an as-of-yet undetermined issue with running yard-tomdoc under
Ruby 1.9. By depending on an internal copy of TomDoc's TomDoc class we
are able to avoid the problem. So, for now we are removing the dependency
on the `tomdoc` gem until this is fully resolved.

Changes:

* Remove dependency on tomdoc.
* Require internal copy of tomdoc/tomdoc.rb.


## 0.2.0 | 2011-05-22

This is first packaged release of YARD-TomDoc. Some minor improvements
have been made from the original version and the project now actually
depends on the `tomdoc` library.

Changes:

* Depend on `tomdoc` library.
* Support YARD's method return object.
* Fix args issues when missing section.
