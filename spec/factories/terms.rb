# == Schema Information
#
# Table name: terms
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  xml_filename :string           not null
#  begin_at     :date             not null
#  end_at       :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_terms_on_begin_at_and_end_at  (begin_at,end_at) UNIQUE
#  index_terms_on_xml_filename         (xml_filename) UNIQUE
#

FactoryGirl.define do
  factory :term do
    name "MyString"
xml_filename "MyString"
begin_at "2014-12-23"
end_at "2014-12-23"
  end

end
