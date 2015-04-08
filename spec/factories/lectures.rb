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

    association :term, factory: :academic_term
    klass

    transient do
      lecturers_count 0
      periods_count 0
    end

    after(:create) do |lecture, evaluator|
      lecture.lecturers =
        create_list(:lecturer, evaluator.lecturers_count)
      lecture.periods =
        create_list(:period, evaluator.periods_count)
    end
  end
end
