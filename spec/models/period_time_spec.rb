# == Schema Information
#
# Table name: period_times
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  start_time :string           not null
#  end_time   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_period_times_on_end_time                 (end_time)
#  index_period_times_on_name                     (name) UNIQUE
#  index_period_times_on_start_time               (start_time)
#  index_period_times_on_start_time_and_end_time  (start_time,end_time) UNIQUE
#

require 'rails_helper'

RSpec.describe PeriodTime, type: :model do
  let(:period_time) { build(:period_time, start_time: start_time, end_time: end_time) }
  let(:start_time) { '09:00:00+09:00' }
  let(:end_time) { '10:30:00+09:00' }
  subject { period_time }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it do
      is_expected.to validate_uniqueness_of(:start_time).scoped_to(:end_time)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:periods) }
  end

  describe '#is?' do
    let(:params) { { start_time: other_start_time, end_time: other_end_time } }
    let(:other_start_time) { start_time }
    let(:other_end_time) { end_time }
    subject { period_time.is?(params) }
    it { is_expected.to eq true }

    context 'when start_time is different' do
      let(:other_start_time) { '' }
      it { is_expected.to eq false }
    end

    context 'when end_time is different' do
      let(:other_end_time) { '' }
      it { is_expected.to eq false }
    end
  end

  describe '#length' do
    subject { period_time.length }
    it { is_expected.to eq 5400.0 }
  end

  describe '#<=>' do
    let(:params) { { start_time: start_time, end_time: end_time } }
    let(:other_start_time) { '09:00:00+09:00' }
    let(:other_end_time) { '10:30:00+09:00' }
    let(:other_params) { { start_time: other_start_time, end_time: other_end_time } }
    subject { PeriodTime.new(params) <=> PeriodTime.new(other_params) }
    context 'with the same start_time and end_time' do
      it { is_expected.to eq 0 }
    end
    context 'with the same start_time and earlier end_time' do
      let(:other_end_time) { '10:00:00+09:00' }
      it { is_expected.to eq 1 }
    end
    context 'with the same start_time and later end_time' do
      let(:other_end_time) { '10:40:00+09:00' }
      it { is_expected.to eq -1 }
    end
    context 'with earlier start_time' do
      let(:other_start_time) { '08:40:00+09:00' }
      it { is_expected.to eq 1 }
    end
    context 'with later start_time' do
      let(:other_start_time) { '09:40:00+09:00' }
      it { is_expected.to eq -1 }
    end
  end
end
