# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category              :integer
#  period_time_id        :integer
#  scheduled_on          :date
#
# Indexes
#
#  index_reschedulings_on_period_time_id  (period_time_id)
#  index_reschedulings_on_scheduled_on    (scheduled_on)
#

FactoryGirl.define do
  factory :rescheduling do
    lecture
    period_time

    trait :cancel do
      category 'cancel'
    end

    trait :addition do
      category 'addition'
    end
  end
end
