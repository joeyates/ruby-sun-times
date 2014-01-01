require 'spec_helper'

describe SunTimes do
  let(:day) { Date.new(2010, 3, 8) }
  let(:latitude) { 43.779 }
  let(:longitude) { 11.432 }
  let(:rise) { Time.gm(2010, 3, 8, 5, 39, 53) }
  let(:set) { Time.gm(2010, 3, 8, 17, 11, 16) }

  describe '#calculate' do
    context ':rise' do
      it 'returns the sunrise time' do
        result = SunTimes.calculate(:rise, day, latitude, longitude)
        expect(result).to be_within(1).of(rise)
      end
    end

    context ':set' do
      it 'returns the sunset time' do
        result = SunTimes.calculate(:set, day, latitude, longitude)
        expect(result).to be_within(1).of(set)
      end
    end

    context 'unknown event' do
      it 'fails' do
        expect {
          SunTimes.calculate(:foo, day, latitude, longitude)
        }.to raise_error(RuntimeError, /unknown event/i)
      end
    end

    context 'with timezone' do
      let(:zone) { Rational(-8, 24) }
      let(:day_with_zone) { DateTime.new(2011, 12, 13, 0, 0, 0, zone) }

      it 'calculates according to the supplied value' do
        set = SunTimes.calculate(:set, day_with_zone, 45.52, -122.681944)
        result_datetime = DateTime.new(set.year, set.month, set.day, set.hour, set.min, set.sec, 0)

        expect(result_datetime).to be > day_with_zone
        expect(result_datetime).to be <= day_with_zone + 1
      end
    end

    context 'midnight sun' do
      # North Cape
      let(:midsummer) { Date.new(2010, 6, 21) }
      let(:latitude) { 71.170219 }
      let(:longitude) { 25.785556 }

      it 'rise is nil' do
        result = SunTimes.calculate(:rise, midsummer, latitude, longitude)
        expect(result).to be_nil
      end

      it 'set is nil' do
        result = SunTimes.calculate(:set, midsummer, latitude, longitude)
        expect(result).to be_nil
      end
    end
  end

  describe '#rise' do
    it 'returns the sunrise time' do
      result = SunTimes.rise(day, latitude, longitude)
      expect(result).to be_within(1).of(rise)
    end
  end

  describe '#set' do
    it 'returns the sunset time' do
      result = SunTimes.set(day, latitude, longitude)
      expect(result).to be_within(1).of(set)
    end
  end
end
