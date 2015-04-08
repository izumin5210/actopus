# coding: utf-8
require 'rails_helper'

describe PeriodDecorator do
  let(:period_time) { build(:period_time, params).extend PeriodDecorator }
  let(:params) do
    { name: '1限', start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' }
  end
  subject { period_time }
  it { is_expected.to be_a PeriodTime }

  describe '#to_display' do
    subject { period_time.to_display }
    it { is_expected.to eq '1限 09:00 ~ 10:30' }
  end
end
