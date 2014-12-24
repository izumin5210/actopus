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

class Lecture < ActiveRecord::Base
  belongs_to :department
  belongs_to :course
  belongs_to :term

  has_many :teaching_lecturers,
    class_name: TeachingLecture.name, foreign_key: :lecture_id
  has_many :lecturers, through: :teaching_lecturers
  has_many :held_lectures
  has_many :periods, through: :held_lectures

  validates :name, presence: true
  validates :grade, presence: true
  validates :department_id, presence: true
  validates :term_id, presence: true
end
