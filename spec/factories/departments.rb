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

    Settings.department.each do |dept_params|
      trait :"#{dept_params.abbreviation_name.downcase}" do
        name dept_params.name
        abbreviation_name dept_params.abbreviation_name
      end
    end
  end
end
