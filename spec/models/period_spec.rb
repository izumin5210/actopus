# == Schema Information
#
# Table name: periods
#
#  id             :integer          not null, primary key
#  period_time_id :integer          not null
#  wday           :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_periods_on_period_time_id           (period_time_id)
#  index_periods_on_period_time_id_and_wday  (period_time_id,wday) UNIQUE
#  index_periods_on_wday                     (wday)
#

require 'rails_helper'

RSpec.describe Period, type: :model do
  let(:period) { build(:period) }
  subject { period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:period_time_id) }
    it { is_expected.to validate_presence_of(:wday) }
    it do
      is_expected.to validate_uniqueness_of(:period_time_id).scoped_to(:wday)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:period_time) }
    it { is_expected.to have_many(:schedulings) }
    it { is_expected.to have_many(:lectures).through(:schedulings) }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:start_time).to(:period_time) }
    it { is_expected.to delegate_method(:end_time).to(:period_time) }
  end

  describe '#is?' do
    let(:params) do
      { start_time: other_start_time,
        end_time: other_end_time, wday: other_wday }
    end
    let(:other_start_time) { period.start_time }
    let(:other_end_time) { period.end_time }
    let(:other_wday) { period.wday }
    subject { period.is?(params) }
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
      let(:other_wday) { -1 }
      it { is_expected.to eq false }
    end
  end
end
