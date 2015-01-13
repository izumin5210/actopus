# == Schema Information
#
# Table name: lectures
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  overseas_student :boolean          default("f")
#  term_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  klass_id         :integer
#  special_target   :string
#
# Indexes
#
#  index_lectures_on_klass_id  (klass_id)
#  index_lectures_on_term_id   (term_id)
#

class Lecture < ActiveRecord::Base
  belongs_to :klass
  belongs_to :term

  has_many :lecturings
  has_many :lecturers, through: :lecturings
  has_many :schedulings
  has_many :wday_periods, through: :schedulings
  has_many :reschedulings

  validates :name, presence: true
  validates :klass_id, presence: true
  validates :term_id, presence: true

  enum special_target: Settings.lecture.special_target
end
