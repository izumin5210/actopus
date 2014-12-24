# == Schema Information
#
# Table name: lecturers
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :lecturer do
    name '新井イスマイル'

    trait :with_department do
      department
    end
  end
end
