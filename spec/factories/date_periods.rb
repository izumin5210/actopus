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

FactoryGirl.define do
  factory :date_period do
    period_id 1
date_on "2015-01-05"
  end

end
