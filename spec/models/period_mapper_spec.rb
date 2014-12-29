require 'rails_helper'

describe PeriodMapper do
  let(:mapper) { PeriodMapper.new(start_time: start_time, end_time: end_time) }
  let(:start_time) { '09:00:00+09:00' }
  let(:end_time) { '10:30:00+09:00' }

  describe '#to_h' do
    subject { mapper.to_h }
    it { is_expected.to match(start_time: start_time, end_time: end_time) }
  end
end
