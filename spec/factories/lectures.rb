# == Schema Information
#
# Table name: lectures
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  term_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  klass_id       :integer
#  special_target :integer
#  code           :string
#
# Indexes
#
#  index_lectures_on_code      (code)
#  index_lectures_on_klass_id  (klass_id)
#  index_lectures_on_term_id   (term_id)
#

FactoryGirl.define do
  factory :lecture do
    sequence(:name, 'A') { |n| "Lecture #{n}" }
    sequence(:code, '2014121002101231110200')

    transient do
      lecturers_count 0
      wday_periods_count 0
    end

    after(:create) do |lecture, evaluator|
      lecture.lecturers =
        create_list(:lecturer, evaluator.lecturers_count)
      lecture.wday_periods =
        create_list(:wday_period, evaluator.wday_periods_count)
    end

    trait :with_klass do
      klass { create(:klass, :with_department, :with_course) }
    end

    trait :with_term do
      term
    end
  end
end
