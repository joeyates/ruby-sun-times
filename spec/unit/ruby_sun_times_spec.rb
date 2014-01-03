require 'spec_helper'

describe SunTimes do
  let(:options) { {} }
  let(:day) { Date.new(2010, 3, 8) }
  let(:latitude) { 43.779 }
  let(:longitude) { 11.432 }
  let(:rise) { Time.gm(2010, 3, 8, 5, 39, 53) }
  let(:set) { Time.gm(2010, 3, 8, 17, 11, 16) }
  let(:midsummer) { Date.new(2010, 6, 21) }
  let(:midwinter) { Date.new(2010, 12, 21) }
  let(:north_cape_latitude) { 71.170219 }
  let(:north_cape_longitude) { 25.785556 }

  subject { described_class.new(options) }

  describe '#calculate' do
    context ':rise' do
      it 'returns the sunrise time' do
        result = subject.calculate(:rise, day, latitude, longitude)
        expect(result).to be_within(1).of(rise)
      end
    end

    context ':set' do
      it 'returns the sunset time' do
        result = subject.calculate(:set, day, latitude, longitude)
        expect(result).to be_within(1).of(set)
      end
    end

    context 'unknown event' do
      it 'fails' do
        expect {
          subject.calculate(:foo, day, latitude, longitude)
        }.to raise_error(RuntimeError, /unknown event/i)
      end
    end

    context 'with timezone' do
      let(:zone) { Rational(-8, 24) }
      let(:day_with_zone) { DateTime.new(2011, 12, 13, 0, 0, 0, zone) }

      it 'calculates according to the supplied value' do
        set = subject.calculate(:set, day_with_zone, 45.52, -122.681944)
        result_datetime = DateTime.new(set.year, set.month, set.day, set.hour, set.min, set.sec, 0)

        expect(result_datetime).to be > day_with_zone
        expect(result_datetime).to be <= day_with_zone + 1
      end
    end

    context 'midnight sun' do
      it 'rise is nil' do
        result = subject.calculate(:rise, midsummer, north_cape_latitude, north_cape_longitude)
        expect(result).to be_nil
      end

      it 'set is nil' do
        result = subject.calculate(:set, midsummer, north_cape_latitude, north_cape_longitude)
        expect(result).to be_nil
      end
    end

    context 'last day of the year' do
      let(:zone) { Rational(-8, 24) }
      let(:day) { DateTime.new(2013, 12, 31, 8, 59, 5, zone) }

      it 'calculates correctly' do
        subject.calculate(:set, day, 47.5, -122)
      end
    end

    context 'options' do
      context ':never_rises_result' do
        let(:options) { {:never_rises_result => :never_rises} }

        it 'uses the supplied value, instead of nil' do
          result = subject.calculate(:rise, midwinter, north_cape_latitude, north_cape_longitude)
          expect(result).to eq(:never_rises)
        end
      end

      context ':never_sets_result' do
        let(:options) { {:never_sets_result => :never_sets} }

        it 'uses the supplied value, instead of nil' do
          result = subject.calculate(:rise, midsummer, north_cape_latitude, north_cape_longitude)
          expect(result).to eq(:never_sets)
        end
      end
    end
  end

  describe '#rise' do
    it 'returns the sunrise time' do
      result = subject.rise(day, latitude, longitude)
      expect(result).to be_within(1).of(rise)
    end
  end

  describe '#set' do
    it 'returns the sunset time' do
      result = subject.set(day, latitude, longitude)
      expect(result).to be_within(1).of(set)
    end
  end
end
