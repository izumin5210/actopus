# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  begin_at   :string           not null
#  end_at     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_periods_on_begin_at_and_end_at  (begin_at,end_at) UNIQUE
#  index_periods_on_name                 (name) UNIQUE
#

FactoryGirl.define do
  factory :period do
    name "MyString"
begin_at "2014-12-23 13:10:32"
end_at "2014-12-23 13:10:32"
  end

end
