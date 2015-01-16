# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :rescheduling do
    lecture
    before_date_period { date_period }
    after_date_period { date_period }
    category 'change'
  end
end
