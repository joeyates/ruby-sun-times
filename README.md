# ruby-sun-times [![Build Status](https://travis-ci.org/joeyates/ruby-sun-times.png?branch=master)][Continuous Integration]

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

```ruby
gem 'ruby-sun-times', require: 'sun_times'
```

Directly:

```ruby
require 'sun_times'
```

## Methods

The two methods `rise` and `set` each return a Time.

```ruby
day = Date.new(2010, 3, 8)
latitude = 43.779
longitude = 11.432
sun_times = SunTimes.new
sun_times.rise(day, latitude, longitude) # => 2010-03-08 05:39:53 UTC
sun_times.set(day, latitude, longitude) # => 2010-03-08 17:11:16 UTC
```

# References

* http://www.astro.uu.nl/~strous/AA/en/reken/zonpositie.html - Calculations
* http://williams.best.vwh.net/sunrise_sunset_algorithm.htm - Algorithm
* http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/264573 - Ken Bloom's implementation
