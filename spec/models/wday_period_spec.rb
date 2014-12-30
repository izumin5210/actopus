# == Schema Information
#
# Table name: wday_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer          not null
#  wday       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wday_periods_on_period_id           (period_id)
#  index_wday_periods_on_period_id_and_wday  (period_id,wday) UNIQUE
#  index_wday_periods_on_wday                (wday)
#

require 'rails_helper'

RSpec.describe WdayPeriod, type: :model do
  let(:wday_period) { build(:wday_period) }
  let(:start_time) { '09:00:00+09:00' }
  let(:end_time) { '10:30:00+09:00' }
  let(:wday) { 1 }
  subject { wday_period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:period_id) }
    it { is_expected.to validate_presence_of(:wday) }
    it do
      is_expected.to validate_uniqueness_of(:period_id).scoped_to(:wday)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:period) }
    it { is_expected.to have_many(:schedulings) }
    it { is_expected.to have_many(:lectures).through(:schedulings) }
  end

  describe '#start_time' do
    it { expect(subject.start_time).to eq '09:00:00+09:00' }
  end

  describe '#end_time' do
    it { expect(subject.end_time).to eq '10:30:00+09:00' }
  end

  describe '#is?' do
    let(:params) { { start_time: start_time, end_time: end_time, wday: wday } }
    subject { wday_period.is?(params) }
    it { is_expected.to eq true }

    context 'when start_time is different' do
      let(:start_time) { '10:00:00+09:00' }
      it { is_expected.to eq false }
    end

    context 'when end_time is different' do
      let(:end_time) { '10:00:00+09:00' }
      it { is_expected.to eq false }
    end

    context 'when wday is different' do
      let(:wday) { 2 }
      it { is_expected.to eq false }
    end
  end
end
