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

class Lecture < ActiveRecord::Base
  belongs_to :klass
  belongs_to :term, class_name: AcademicTerm.name

  has_many :lecturings
  has_many :lecturers, through: :lecturings
  has_many :schedulings
  has_many :wday_periods, through: :schedulings
  has_many :reschedulings

  validates :name, presence: true
  validates :klass_id, presence: true
  validates :term_id, presence: true

  enum special_target: Settings.lecture.special_target

  delegate :grade, :department, :course, to: :klass
  delegate :name, to: :department, prefix: :department
  delegate :name, to: :course, prefix: :course, allow_nil: true

  include Garage::Representer
  include Garage::Authorizable

  property :name
  property :special_target, if: -> (record, _) { record.special_target.present? }
  property :code
  property :grade
  property :department_name, as: :department
  property :course_name, as: :course, if: -> (record, _) { record.course.present? }
  collection :lecturer_names, as: :lecturers
  collection :wday_periods, as: :periods

  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end

  def build_permissions(perms, other)
    perms.permits! :read
  end

  def lecturer_names
    lecturers.map(&:name)
  end
end
