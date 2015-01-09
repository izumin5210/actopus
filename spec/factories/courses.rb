# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_courses_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_courses_on_name               (name) UNIQUE
#

FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Course#{n}" }
    sequence(:abbreviation_name, 'A')
  end
end
