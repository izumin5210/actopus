require 'rails_helper'

describe PeriodMapper do
  let(:mapper) do
    PeriodMapper.new(wday: wday, start_time: start_time, end_time: end_time)
  end
  let(:wday) { 1 }
  let(:start_time) { '09:00:00+09:00' }
  let(:end_time) { '10:30:00+09:00' }

  describe '#to_h' do
    subject { mapper.to_h }
    it do
      is_expected.to match(
        wday: wday, start_time: start_time, end_time: end_time
      )
    end
  end
end
