# == Schema Information
#
# Table name: terms
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  xml_filename :string           not null
#  started_on   :date             not null
#  ended_on     :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_terms_on_ended_on                 (ended_on)
#  index_terms_on_started_on               (started_on)
#  index_terms_on_started_on_and_ended_on  (started_on,ended_on) UNIQUE
#  index_terms_on_xml_filename             (xml_filename) UNIQUE
#

class Term < ActiveRecord::Base
  has_many :lectures

  validates :name, presence: true
  validates :xml_filename, presence: true
  validates :started_on, presence: true
  validates :ended_on, presence: true
  validates_with StartAndEndDateValidator
end
