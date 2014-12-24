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
    name '1'
    begin_at '09:00:00+09:00'
    end_at '10:30:00+09:00'

    Settings.period.each do |period_params|
      trait :"#{period_params.name.downcase}" do
        name period_params.name
        begin_at period_params.begin_at
        end_at period_params.end_at
      end
    end
  end
end
