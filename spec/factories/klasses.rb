# == Schema Information
#
# Table name: klasses
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer          not null
#  course_id     :integer
#  grade         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category      :integer
#  slug          :string
#
# Indexes
#
#  index_klasses_on_category                               (category)
#  index_klasses_on_course_id                              (course_id)
#  index_klasses_on_department_id                          (department_id)
#  index_klasses_on_department_id_and_course_id_and_grade  (department_id,course_id,grade) UNIQUE
#  index_klasses_on_grade                                  (grade)
#  index_klasses_on_name                                   (name) UNIQUE
#  index_klasses_on_slug                                   (slug) UNIQUE
#

FactoryGirl.define do
  factory :klass do
    sequence(:name, 'A') { |n| "#{grade}#{n}" }
    sequence(:grade) { |n| (n % 5) + 1 }
    category :undergraduate

    department

    trait :with_course do
      course
    end
  end
end
