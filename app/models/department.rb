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

class Department < ActiveRecord::Base
  has_many :klasses
  has_many :lecturers

  validates :name, presence: true, uniqueness: true
  validates :abbreviation_name, presence: true, uniqueness: true

  include Garage::Representer

  property :name
end
