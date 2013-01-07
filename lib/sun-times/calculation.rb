module SunTimes
  class Calculation
    attr_accessor :event, :date, :latitude, :longitude, :options
    attr_accessor :zenith

    def initialize(event, date, latitude, longitude, options = {})
      raise "Unknown event '#{ event }'" if KNOWN_EVENTS.find_index(event).nil?

      self.event     = event
      self.date      = date
      self.latitude  = latitude
      self.longitude = longitude
      self.options   = options

      self.zenith = options.delete(:zenith) || DEFAULT_ZENITH
    end

    def calculate
      longitude_hour = longitude / DEGREES_PER_HOUR

      # t
      base_time = event == :rise ? 6.0 : 18.0
      approximate_time = date.yday + (base_time - longitude_hour) / 24.0

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
        (Math.cos(degrees_to_radians(zenith)) - (sin_declination * Math.sin(degrees_to_radians(latitude)))) /
        (cos_declination * Math.cos(degrees_to_radians(latitude)))

      # the sun never rises on this location (on the specified date)
      return nil if cos_local_hour_angle > 1
      # the sun never sets on this location (on the specified date)
      return nil if cos_local_hour_angle < -1

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

      hour = gmt_hours.floor
      hour_remainder = (gmt_hours.to_f - hour.to_f) * 60.0
      minute = hour_remainder.floor
      seconds = (hour_remainder - minute) * 60.0

      Time.gm(date.year, date.month, date.day, hour, minute, seconds)
    end

    private

    def degrees_to_radians(degrees)
      degrees.to_f / 360.0 * 2.0 * Math::PI
    end

    def radians_to_degrees(radians)
      radians.to_f * 360.0 / (2.0 * Math::PI)
    end

    def coerce_degrees(degrees)
      if degrees < 0
        degrees += 360
        return coerce_degrees(degrees)
      end
      if degrees >= 360
        degrees -= 360
        return coerce_degrees(degrees)
      end
      degrees
    end
  end
end
