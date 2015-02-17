# == Schema Information
#
# Table name: reschedulings
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  period_id  :integer
#  taken_on   :date
#
# Indexes
#
#  index_reschedulings_on_category    (category)
#  index_reschedulings_on_lecture_id  (lecture_id)
#  index_reschedulings_on_period_id   (period_id)
#  index_reschedulings_on_taken_on    (taken_on)
#

FactoryGirl.define do
  factory :rescheduling do
    lecture
    before_date_period { date_period }
    after_date_period { date_period }
    category 'change'
  end
end
