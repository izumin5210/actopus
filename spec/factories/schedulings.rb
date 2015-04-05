# == Schema Information
#
# Table name: schedulings
#
#  id             :integer          not null, primary key
#  lecture_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  wday_period_id :integer          not null
#
# Indexes
#
#  index_schedulings_on_lecture_id_and_wday_period_id  (lecture_id,wday_period_id) UNIQUE
#

FactoryGirl.define do
  factory :scheduling do
    lecture { create(:lecture, :with_klass) }
    wday_period
  end
end
