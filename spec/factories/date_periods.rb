# == Schema Information
#
# Table name: date_periods
#
#  id             :integer          not null, primary key
#  period_time_id :integer
#  taken_on       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :date_period do
    sequence(:taken_on) { |n| Date.today + n }
    period_time
  end
end
