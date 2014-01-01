# encoding: utf-8
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'test/unit'
require 'sun_times'
require 'date'

class SunTimesTest < Test::Unit::TestCase

=begin
  def test_time
    datetime = Time.gm(2010, 6, 13, 0, 0, 0)
    set = SunTimes.calculate(:set, datetime, 43.779, 11.432)
    assert_equal(Time.gm(2010, 6, 13, 18, 56, 55), set)
  end

  def test_datetime
    datetime = DateTime.new(2010, 6, 13, 0, 0, 0)
    set = SunTimes.calculate(:set, datetime, 43.779, 11.432)
    assert_equal(Time.gm(2010, 6, 13, 18, 56, 55), set)
  end

  def test_31st_december
  end
=end
end
