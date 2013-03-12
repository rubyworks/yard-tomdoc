# YARD TomDoc

[Website](http://rubyworks.github.com/yard-tomdoc) /
[Documentation](http://rubydoc.info/gems/yard-tomdoc/frames) /
[Issues](http://github.com/rubyworks/yard-tomdoc/issues) /
[Source Code](http://github.com/rubyworks/yard-tomdoc)

[![Gem Version](https://badge.fury.io/rb/yard-tomdoc.png)](http://badge.fury.io/rb/yard-tomdoc)
[![Build Status](https://secure.travis-ci.org/rubyworks/yard-tomdoc.png)](http://travis-ci.org/rubyworks/yard-tomdoc) &nbsp; &nbsp;
[![Flattr Me](http://api.flattr.com/button/flattr-badge-large.png)](http://flattr.com/thing/324911/Rubyworks-Ruby-Development-Fund)


## Description

Implements [TomDoc](http://tomdoc.org) syntax for YARD. 'Nuff said.


## Instruction

Since `yard-tomdoc` is a standard YARD plugin, utilize it with yard's
`--plugin` option.

    $ yard --plugin tomdoc [...]


## Limitations

Before you use yard-tomdoc you should read [Loren Segal's blog post](http://gnuu.org/2010/05/12/whats-missing-from-tomdoc/)
about the differences between YARD and TomDoc syntax. But note that the YARD
TomDoc plugin now supports a superset of TomDoc's syntax which provides additional
YARD functionality via *cap-tags*. For example using `Author: James Deam` in the
documentation is equivalent to using `@author James Dean` in regular YARD syntax.
Support is limited, but it opens up much more of YARD's goodness to TomDoc
users then Loren's blog post suggests.


## Acknowledgements

Huge thanks to Loren Segal, the creator of YARD and the original author of this
plugin. Without his patient assistance and coding genius, this library would not
have been possible.


## Licensing

YARD TomDoc is copyrighted open-source software.

Copyright (c) 2010 Rubyworks. All rights reserved.

YARD TomDoc can be modified and redistributed in accordance with the terms
of the **MIT** licsnse.

See the `LICENSE.txt` file for details.
