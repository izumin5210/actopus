# == Schema Information
#
# Table name: date_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer
#  taken_on   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DatePeriod, type: :model do
  let(:date_period) { build(:date_period) }
  subject { date_period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:period_id) }
    it { is_expected.to validate_presence_of(:taken_on) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:period) }
    it do
      is_expected.to have_many(:before_reschedulings)
        .class_name('Rescheduling').with_foreign_key(:before_date_period_id)
    end
    it do
      is_expected.to have_many(:after_reschedulings)
        .class_name('Rescheduling').with_foreign_key(:after_date_period_id)
    end
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:start_time).to(:period) }
    it { is_expected.to delegate_method(:end_time).to(:period) }
  end
end
