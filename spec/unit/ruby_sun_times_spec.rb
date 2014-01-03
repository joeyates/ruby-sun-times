require 'spec_helper'

describe SunTimes do
  let(:options) { {} }
  let(:day) { Date.new(2010, 3, 8) }
  let(:latitude) { 43.779 }
  let(:longitude) { 11.432 }
  let(:midsummer) { Date.new(2010, 6, 21) }
  let(:midwinter) { Date.new(2010, 12, 21) }
  let(:north_cape_latitude) { 71.170219 }
  let(:north_cape_longitude) { 25.785556 }

  subject { described_class.new(options) }

  shared_examples_for 'never sets and never rises options' do |method|
    context ':never_rises_result' do
      let(:options) do
        {
          :never_rises_result => :never_rises,
          :never_sets_result => :never_sets,
        }
      end

      context 'never rises' do
        it 'uses the supplied value' do
          result = subject.send(method, midwinter, north_cape_latitude, north_cape_longitude)
          expect(result).to eq(:never_rises)
        end
      end

      context 'never sets' do
        it 'uses the supplied value' do
          result = subject.send(method, midsummer, north_cape_latitude, north_cape_longitude)
          expect(result).to eq(:never_sets)
        end
      end
    end
  end

  shared_examples_for 'timezones' do |method|
    context 'with timezone' do
      let(:zone) { Rational(-8, 24) }
      let(:day_with_zone) { DateTime.new(2011, 12, 13, 0, 0, 0, zone) }

      it 'calculates according to the supplied value' do
        set = subject.send(method, day_with_zone, 45.52, -122.681944)
        result_datetime = DateTime.new(set.year, set.month, set.day, set.hour, set.min, set.sec, 0)

        expect(result_datetime).to be > day_with_zone
        expect(result_datetime).to be <= day_with_zone + 1
      end
    end
  end

  shared_examples_for 'no event' do |method|
    context 'midnight sun' do
      it 'is nil' do
        result = subject.send(method, midsummer, north_cape_latitude, north_cape_longitude)
        expect(result).to be_nil
      end
    end

    context 'continuous night' do
      it 'is nil' do
        result = subject.send(method, midwinter, north_cape_latitude, north_cape_longitude)
        expect(result).to be_nil
      end
    end
  end

  shared_examples_for 'limiting cases' do |method|
    context 'last day of the year' do
      let(:zone) { Rational(-8, 24) }
      let(:day) { DateTime.new(2013, 12, 31, 8, 59, 5, zone) }

      it 'calculates correctly' do
        subject.send(method, day, 47.5, -122)
      end
    end
  end

  describe '#rise' do
    let(:rise) { Time.gm(2010, 3, 8, 5, 39, 53) }

    it 'returns the sunrise time' do
      result = subject.rise(day, latitude, longitude)
      expect(result).to be_within(1).of(rise)
    end

    include_examples 'timezones', :rise
    include_examples 'limiting cases', :rise
    include_examples 'no event', :rise

    context 'options' do
      include_examples 'never sets and never rises options', :rise
    end
  end

  describe '#set' do
    let(:set) { Time.gm(2010, 3, 8, 17, 11, 16) }

    it 'returns the sunset time' do
      result = subject.set(day, latitude, longitude)
      expect(result).to be_within(1).of(set)
    end

    include_examples 'timezones', :set
    include_examples 'limiting cases', :set
    include_examples 'no event', :rise

    context 'options' do
      include_examples 'never sets and never rises options', :set
    end
  end
end
