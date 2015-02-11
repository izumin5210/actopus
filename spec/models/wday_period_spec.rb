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
  let(:period) { create(:period, start_time: start_time, end_time: end_time) }
  let(:wday_period) { create(:wday_period, period: period, wday: wday) }
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

  describe 'delegations' do
    it { is_expected.to delegate_method(:start_time).to(:period) }
    it { is_expected.to delegate_method(:end_time).to(:period) }
  end

  describe '#is?' do
    let(:params) do
      { start_time: other_start_time,
        end_time: other_end_time, wday: other_wday }
    end
    let(:other_start_time) { start_time }
    let(:other_end_time) { end_time }
    let(:other_wday) { wday }
    subject { wday_period.is?(params) }
    it { is_expected.to eq true }

    context 'when start_time is different' do
      let(:other_start_time) { '' }
      it { is_expected.to eq false }
    end

    context 'when end_time is different' do
      let(:other_end_time) { '' }
      it { is_expected.to eq false }
    end

    context 'when wday is different' do
      let(:other_wday) { 12 }
      it { is_expected.to eq false }
    end
  end
end
