# == Schema Information
#
# Table name: klasses
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer          not null
#  course_id     :integer
#  grade         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category      :integer
#  slug          :string
#
# Indexes
#
#  index_klasses_on_category                               (category)
#  index_klasses_on_course_id                              (course_id)
#  index_klasses_on_department_id                          (department_id)
#  index_klasses_on_department_id_and_course_id_and_grade  (department_id,course_id,grade) UNIQUE
#  index_klasses_on_grade                                  (grade)
#  index_klasses_on_name                                   (name) UNIQUE
#  index_klasses_on_slug                                   (slug) UNIQUE
#

class Klass < ActiveRecord::Base
  belongs_to :department
  belongs_to :course

  has_many :lectures

  validates :name, presence: true, uniqueness: true
  validates :department_id, presence: true
  validates :grade,
    presence: true, uniqueness: { scope: [:department_id, :course_id] }
  validates :category, presence: true

  enum category: Settings.klass.category

  delegate :name, to: :department, prefix: :department
  delegate :name, to: :course, prefix: :course

  extend FriendlyId
  friendly_id :name, use: :slugged

  include Garage::Representer
  include Garage::Authorizable

  property :slug, as: :id
  property :name
  property :grade
  property :department_name, as: :department
  property :course_name, as: :course, if: -> (record, _) { record.course.present? }

  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end

  def build_permissions(perms, other)
    perms.permits! :read
  end

  include LectureSchedulable
end
