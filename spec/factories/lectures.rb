# == Schema Information
#
# Table name: lectures
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  grade            :integer          not null
#  overseas_student :boolean          default("f")
#  department_id    :integer          not null
#  course_id        :integer
#  term_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :lecture do
    name 'プログラミングI'
    grade 1
    overseas_student false
    department
    term

    trait :with_course do
      course
    end

    trait :with_lecturers do
      after(:create) do |lecture, _evaluator|
        create(:lecturer, lectures: [lecture], department: lecture.department)
      end
    end

    trait :with_periods do
      after(:create) do |lecture, _evaluator|
        create(:period, lectures: [lecture])
      end
    end
  end
end
