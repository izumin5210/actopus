# == Schema Information
#
# Table name: lectures
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  overseas_student :boolean          default("f")
#  term_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  klass_id         :integer
#
# Indexes
#
#  index_lectures_on_klass_id  (klass_id)
#  index_lectures_on_term_id   (term_id)
#

FactoryGirl.define do
  factory :lecture do
    name 'プログラミングI'
    overseas_student false
    term

    trait :with_lecturers do
      after(:create) do |lecture, _evaluator|
        create(:lecturer, lectures: [lecture], department: lecture.department)
      end
    end

    trait :with_periods do
      after(:create) do |lecture, _evaluator|
        lecture.wday_periods.create(wday: 1, period: create(:period))
      end
    end
  end
end
