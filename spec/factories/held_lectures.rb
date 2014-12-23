# == Schema Information
#
# Table name: held_lectures
#
#  id         :integer          not null, primary key
#  lecture_id :integer          not null
#  period_id  :integer          not null
#  wday       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_held_lectures_on_lecture_id_and_period_id_and_wday  (lecture_id,period_id,wday) UNIQUE
#

FactoryGirl.define do
  factory :held_lecture do
    wday 1
    lecture
    period
  end
end
