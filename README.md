# SunTimes
[![Build Status](https://secure.travis-ci.org/timoschilling/sun-times.png?branch=master)](http://travis-ci.org/timoschilling/sun-times)

_This is a Fork of [joeyates/ruby-sun-times](https://github.com/joeyates/ruby-sun-times) and is avalible as [sun-times gem](https://rubygems.org/gems/sun-times) so there is no explicit `require` necessary in rails projects._

Calculates sunrise and sunset times.

An implementation of the algorithm described at http://williams.best.vwh.net/sunrise_sunset_algorithm.htm

## Installation

Add this line to your application's Gemfile:

    gem 'sun-times'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sun-times

## Usage

    SunTimes.rise(Date.new(2010, 3, 8), 51.506318, 7.460659)
    SunTimes.set(Date.new(2010, 3, 8), 51.506318, 7.460659)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## References

* http://www.astro.uu.nl/~strous/AA/en/reken/zonpositie.html - Calculations
* http://williams.best.vwh.net/sunrise_sunset_algorithm.htm - Algorithm
* http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/264573 - Ken Bloom's implementation
