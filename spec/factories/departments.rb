# == Schema Information
#
# Table name: departments
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_departments_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_departments_on_name               (name) UNIQUE
#

FactoryGirl.define do
  factory :department do
    sequence(:name) { |n| "Department#{n}" }
    sequence(:abbreviation_name, 'A')
  end
end
