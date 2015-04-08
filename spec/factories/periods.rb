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

FactoryGirl.define do
  factory :period do
    sequence(:wday)
    period_time
  end
end
