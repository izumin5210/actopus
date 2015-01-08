# == Schema Information
#
# Table name: klasses
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer          not null
#  course_id     :integer
#  grade         :integer          not null
#  category      :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_klasses_on_course_id                              (course_id)
#  index_klasses_on_department_id                          (department_id)
#  index_klasses_on_department_id_and_course_id_and_grade  (department_id,course_id,grade) UNIQUE
#  index_klasses_on_grade                                  (grade)
#  index_klasses_on_name                                   (name) UNIQUE
#

class Klass < ActiveRecord::Base
end
