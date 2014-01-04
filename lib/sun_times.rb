#--
# Copyright (c) 2010 Joe Yates
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

# Algorithm from http://williams.best.vwh.net/sunrise_sunset_algorithm.htm

require 'date'

class SunTimes
  DEFAULT_ZENITH = 90.83333
  KNOWN_EVENTS = [:rise, :set]
  DEGREES_PER_HOUR = 360.0 / 24.0

  attr_reader :options

  # Deprecated: use SunTimes.new.rise(...)
  def self.rise(date, latitude, longitude, options = {})
    new(options).calculate(:rise, date, latitude, longitude, options)
  end

  # Deprecated: use SunTimes.new.set(...)
  def self.set(date, latitude, longitude, options = {})
    new(options).calculate(:set, date, latitude, longitude, options)
  end

  # Deprecated: use SunTimes.new.rise/set(...)
  def self.calculate(event, date, latitude, longitude, options = {})
    new(options).calculate(event, date, latitude, longitude)
  end

  # * +options+ -
  #   * <tt>:never_rises_result</tt> - the value to be returned if the sun never rises on the supplied date,
  #   * <tt>:never_sets_result</tt> - the value to be returned if the sun never sets on the supplied date,
  #   * <tt>:zenith</tt> - default 90.83333
  def initialize(options = {})
    @options = {
      :never_sets_result  => nil,
      :never_rises_result => nil,
      :zenith             => DEFAULT_ZENITH,
    }.merge(options)
  end

  # Calculates the sunrise time for a specific date and location
  #
  # ==== Parameters
  # * +date+ - An object that responds to :to_datetime.
  # * +latitude+ - The latitude of the location in degrees.
  # * +longitude+ - The longitude of the location in degrees.
  #
  # ==== Example
  #   SunTimes.new.rise(Date.new(2010, 3, 8), 43.779, 11.432)
  #   > Mon Mar 08 05:39:53 UTC 2010
  def rise(date, latitude, longitude)
    calculate(:rise, date, latitude, longitude)
  end

  # calculates sunset, see #rise for parameters
  def set(date, latitude, longitude)
    calculate(:set, date, latitude, longitude)
  end

  private

  def calculate(event, date, latitude, longitude)
    datetime = to_datetime(date)
    raise "Unknown event '#{event}'" unless KNOWN_EVENTS.include?(event)

    # lngHour
    longitude_hour = longitude / DEGREES_PER_HOUR

    # t
    base_time =
      if event == :rise
        6.0
      else
        18.0
      end
    approximate_time = datetime.yday + (base_time - longitude_hour) / 24.0

    # M
    mean_sun_anomaly = (0.9856 * approximate_time) - 3.289

    # L
    sun_true_longitude = mean_sun_anomaly +
                        (1.916 * Math.sin(degrees_to_radians(mean_sun_anomaly))) +
                        (0.020 * Math.sin(2 * degrees_to_radians(mean_sun_anomaly))) +
                        282.634
    sun_true_longitude = coerce_degrees(sun_true_longitude)

    # RA
    tan_right_ascension = 0.91764 * Math.tan(degrees_to_radians(sun_true_longitude))
    sun_right_ascension = radians_to_degrees(Math.atan(tan_right_ascension))
    sun_right_ascension = coerce_degrees(sun_right_ascension)

    # right ascension value needs to be in the same quadrant as L
    sun_true_longitude_quadrant  = (sun_true_longitude  / 90.0).floor * 90.0
    sun_right_ascension_quadrant = (sun_right_ascension / 90.0).floor * 90.0
    sun_right_ascension += (sun_true_longitude_quadrant - sun_right_ascension_quadrant)

    # RA = RA / 15
    sun_right_ascension_hours = sun_right_ascension / DEGREES_PER_HOUR

    sin_declination = 0.39782 * Math.sin(degrees_to_radians(sun_true_longitude))
    cos_declination = Math.cos(Math.asin(sin_declination))

    cos_local_hour_angle =
      (Math.cos(degrees_to_radians(options[:zenith])) - (sin_declination * Math.sin(degrees_to_radians(latitude)))) /
      (cos_declination * Math.cos(degrees_to_radians(latitude)))

    # the sun never rises on this location (on the specified date)
    return options[:never_rises_result] if cos_local_hour_angle > 1
    # the sun never sets on this location (on the specified date)
    return options[:never_sets_result] if cos_local_hour_angle < -1

    # H
    suns_local_hour =
      if event == :rise
        360 - radians_to_degrees(Math.acos(cos_local_hour_angle))
      else
        radians_to_degrees(Math.acos(cos_local_hour_angle))
      end

    # H = H / 15
    suns_local_hour_hours = suns_local_hour / DEGREES_PER_HOUR

    # T = H + RA - (0.06571 * t) - 6.622
    local_mean_time = suns_local_hour_hours + sun_right_ascension_hours - (0.06571 * approximate_time) - 6.622

    # UT = T - lngHour
    gmt_hours = local_mean_time - longitude_hour
    gmt_hours -= 24.0 if gmt_hours > 24
    gmt_hours += 24.0 if gmt_hours <  0

    offset_hours = datetime.offset * 24.0

    if gmt_hours + offset_hours < 0
      next_day = next_day(datetime)
      return calculate(event, next_day.new_offset, latitude, longitude)
    end
    if gmt_hours + offset_hours > 24
      previous_day = prev_day(datetime)
      return calculate(event, previous_day.new_offset, latitude, longitude)
    end

    hour = gmt_hours.floor
    hour_remainder = (gmt_hours.to_f - hour.to_f) * 60.0
    minute = hour_remainder.floor
    seconds = (hour_remainder - minute) * 60.0

    Time.gm(datetime.year, datetime.month, datetime.day, hour, minute, seconds)
  end

  ############################
  # ruby 1.8 compatibility

  def to_datetime(date)
    if date.respond_to?(:to_datetime)
      date.to_datetime
    else
      values = [
        date.year,
        date.month,
        date.day,
      ]
      [:hour, :minute, :second, :zone].each do |m|
        values <<
          if date.respond_to?(m)
            date.send(m)
          else
            0
          end
      end
      DateTime.new(*values)
    end
  end

  def prev_day(datetime)
    datetime - 1
  end

  def next_day(datetime)
    datetime + 1
  end

  ############################

  def degrees_to_radians(d)
    d.to_f / 360.0 * 2.0 * Math::PI
  end

  def radians_to_degrees(r)
    r.to_f * 360.0 / (2.0 * Math::PI)
  end

  def coerce_degrees(d)
    if d < 0
      d += 360
      return coerce_degrees(d)
    end
    if d >= 360
      d -= 360
      return coerce_degrees(d)
    end
    d
  end
end
