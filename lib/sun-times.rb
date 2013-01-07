require 'date'
require 'sun-times/calculation'

module SunTimes
  DEFAULT_ZENITH = 90.83333
  KNOWN_EVENTS = [:rise, :set]
  DEGREES_PER_HOUR = 360.0 / 24.0

  # Helper method: calculates sunrise, with the same parameters as calculate
  def self.rise(date, latitude, longitude, options = {})
    calculate(:rise, date, latitude, longitude, options)
  end

  # Helper method: calculates sunset, with the same parameters as calculate
  def self.set(date, latitude, longitude, options = {})
    calculate(:set, date, latitude, longitude, options)
  end

  # Calculates the sunrise or sunset time for a specific date and location
  #
  # ==== Parameters
  # * +event+ - One of :rise, :set.
  # * +date+ - An object that responds to yday.
  # * +latitude+ - The latitude of the location in degrees.
  # * +longitude+ - The longitude of the location in degrees.
  # * +options+ - Additional option is <tt>:zenith</tt>.
  #
  # ==== Example
  #   SunTimes.calculate(:rise, Date.new(2010, 3, 8), 43.779, 11.432)
  #   > Mon Mar 08 05:39:53 UTC 2010
  def self.calculate(event, date, latitude, longitude, options = {})
    Calculation.new(event, date, latitude, longitude, options).calculate
  end
end
