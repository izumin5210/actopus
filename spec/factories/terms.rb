# == Schema Information
#
# Table name: terms
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  xml_filename :string           not null
#  start_on     :date             not null
#  end_on       :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_terms_on_end_on               (end_on)
#  index_terms_on_start_on             (start_on)
#  index_terms_on_start_on_and_end_on  (start_on,end_on) UNIQUE
#  index_terms_on_xml_filename         (xml_filename) UNIQUE
#

FactoryGirl.define do
  factory :term do
    name '後期'
    xml_filename 'timetable201410.xml'
    start_on { Date.parse('2014-10-1') }
    end_on { Date.parse('2015-2-28') }
  end
end
