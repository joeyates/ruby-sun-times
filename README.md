# ruby-sun-times [![Build Status](https://secure.travis-ci.org/joeyates/ruby-run-times.png)][Continuous Integration]

*Calculates sunrise and sunset times*

  * [Source Code]
  * [API documentation]
  * [Rubygem]
  * [Continuous Integration]

[Source Code]: https://github.com/joeyates/ruby-sun-times "Source code at GitHub"
[API documentation]: http://rubydoc.info/gems/ruby-sun-times/frames "RDoc API Documentation at Rubydoc.info"
[Rubygem]: http://rubygems.org/gems/ruby-sun-times "Ruby gem at rubygems.org"
[Continuous Integration]: http://travis-ci.org/joeyates/ruby-sun-times "Build status by Travis-CI"

An implementation of the algorithm descibed at http://williams.best.vwh.net/sunrise_sunset_algorithm.htm

# Usage

## Requiring

In a Gemfile/Gemspec:

```
gem 'ruby-sun-times', require: 'sun_times'
```

Directly:

```ruby
require 'sun_times'
```

## Calls

There are two helper methods: 'rise' and 'set'.

```
day = Date.new(2010, 3, 8)
latitude = 43.779
longitude = 11.432
puts SunTimes.set(day, latitude, longitude)
```

# References

* http://www.astro.uu.nl/~strous/AA/en/reken/zonpositie.html - Calculations
* http://williams.best.vwh.net/sunrise_sunset_algorithm.htm - Algorithm
* http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/264573 - Ken Bloom's implementation

# Licence

This code is free to use under the terms of the MIT licence:

  Copyright (c) 2010 - 2013 Joe Yates

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
