# == Schema Information
#
# Table name: lecturers
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Lecturer < ActiveRecord::Base
  belongs_to :department

  has_many :lecturings
  has_many :lectures, through: :lecturings

  validates :name, presence: true

  include Garage::Representer

  property :name

  include LectureSchedulable
end
