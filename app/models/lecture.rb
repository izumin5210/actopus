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
#  klass_id         :integer
#
# Indexes
#
#  index_lectures_on_klass_id  (klass_id)
#

class Lecture < ActiveRecord::Base
  belongs_to :klass
  belongs_to :department
  belongs_to :course
  belongs_to :term

  has_many :lecturings
  has_many :lecturers, through: :lecturings
  has_many :schedulings
  has_many :wday_periods, through: :schedulings
  has_many :reschedulings

  validates :name, presence: true
  validates :grade, presence: true
  validates :department_id, presence: true
  validates :term_id, presence: true
end
