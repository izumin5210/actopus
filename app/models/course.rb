# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_courses_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_courses_on_name               (name) UNIQUE
#

class Course < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :abbreviation_name, presence: true, uniqueness: true
end
