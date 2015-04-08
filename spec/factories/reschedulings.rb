# == Schema Information
#
# Table name: reschedulings
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#

FactoryGirl.define do
  factory :rescheduling do
    lecture
    before_date_period { date_period }
    after_date_period { date_period }
    category 'change'
  end
end
