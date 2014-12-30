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
    name '情報工学コース'
    abbreviation_name 'J'

    Settings.course.each do |course_params|
      trait :"#{course_params.abbreviation_name.downcase}" do
        name course_params.name
        abbreviation_name course_params.abbreviation_name
      end
    end
  end
end
