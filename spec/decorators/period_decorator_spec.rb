# coding: utf-8
require 'rails_helper'

describe PeriodDecorator do
  let(:period) { build(:period, params).extend PeriodDecorator }
  let(:params) do
    { name: '1限', start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' }
  end
  subject { period }
  it { is_expected.to be_a Period }

  describe '#to_display' do
    subject { period.to_display }
    it { is_expected.to eq '1限 09:00 ~ 10:30' }
  end
end
