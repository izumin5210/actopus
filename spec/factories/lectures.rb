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
    name "MyString"
grade 1
overseas_student false
department_id 1
course_id 1
term_id 1
  end

end
