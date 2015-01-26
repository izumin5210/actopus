# == Schema Information
#
# Table name: academic_terms
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
#  index_academic_terms_on_ended_on                 (ended_on)
#  index_academic_terms_on_started_on               (started_on)
#  index_academic_terms_on_started_on_and_ended_on  (started_on,ended_on) UNIQUE
#  index_academic_terms_on_xml_filename             (xml_filename) UNIQUE
#

FactoryGirl.define do
  factory :academic_term do
    sequence(:name) { |n| "#{n}期" }
    sequence(:xml_filename) do |n|
      "timetable#{(Date.today + n).strftime('%Y%m')}.xml"
    end
    sequence(:started_on) { |n| Date.parse('2014-10-1') + n.month }
    sequence(:ended_on) { |n| Date.parse('2015-2-28') + n.month }
  end
end
