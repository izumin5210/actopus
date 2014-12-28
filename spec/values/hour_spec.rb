require 'rails_helper'

describe Hour do
  let(:hour_str) { '09:00:00+09:00' }
  let(:hour) { Hour.new(hour_str) }
  subject { hour }

  describe '#<=>' do
    let(:other_hour) { Hour.new(other_hour_str) }
    subject { hour <=> other_hour }
    context 'when the hour later than the other hour' do
      let(:other_hour_str) { '08:20:00+09:00' }
      it { is_expected.to eq 1 }
    end

    context 'when the hour earlier than the other hour' do
      let(:other_hour_str) { '15:30:00+09:00' }
      it { is_expected.to eq(-1) }
    end

    context 'when the hour the same as the other hour' do
      let(:other_hour_str) { '09:00:00+09:00' }
      it { is_expected.to eq 0 }
    end
  end

  describe '#to_time' do
    subject { hour.to_time }
    it { is_expected.to eq Time.parse(hour_str) }
  end

  describe '#to_s' do
    subject { hour.to_s }
    it { is_expected.to eq hour_str }
  end
end
