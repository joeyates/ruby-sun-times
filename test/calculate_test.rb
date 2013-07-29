# encoding: utf-8
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'test/unit'
require 'sun_times'
require 'date'

class SunTimesTest < Test::Unit::TestCase

  def test_rise_20100308_pontassieve
    rise = SunTimes.calculate(:rise, Date.new(2010, 3, 8), 43.779, 11.432)
    assert_equal(Time.gm(2010, 3, 8, 5, 39, 53), rise)
  end

  def test_set_20100308_pontassieve
    set = SunTimes.calculate(:set, Date.new(2010, 3, 8), 43.779, 11.432)
    assert_equal(Time.gm(2010, 3, 8, 17, 11, 16), set)
  end

  def test_rise_helper
    rise = SunTimes.rise(Date.new(2010, 3, 8), 43.779, 11.432)
    assert_equal(Time.gm(2010, 3, 8, 5, 39, 53), rise)
  end

  def test_set_helper
    set = SunTimes.set(Date.new(2010, 3, 8), 43.779, 11.432)
    assert_equal(Time.gm(2010, 3, 8, 17, 11, 16), set)
  end

  def test_midnight_sun_on_20100621_north_cape
    rise = SunTimes.calculate(:rise, Date.new(2010, 6, 21), 71.170219, 25.785556)
    assert_nil(rise)
    set = SunTimes.calculate(:set, Date.new(2010, 6, 21), 71.170219, 25.785556)
    assert_nil(set)
  end

  def test_last_day_of_month
    date = Date.new(2013,07,31)
    assert_not_raise { SunTimes.set(date, 50,50) }
  end

  def test_unknown_event
    assert_raise(RuntimeError) { SunTimes.calculate(:foo, Date.new(2010, 3, 8), 43.779, 11.432) }
  end

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

  def test_respects_timezone_if_supplied
    pst = DateTime.new(2011, 12, 13, 0, 0, 0, Rational(-8, 24))
    set = SunTimes.calculate(:set, pst, 45.52, -122.681944)
    result_datetime = DateTime.new(set.year, set.month, set.day, set.hour, set.min, set.sec, 0)
    assert(pst < result_datetime)
    assert(pst + 1 > result_datetime)
  end

end
