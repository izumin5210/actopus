# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  start_time :string           not null
#  end_time   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_periods_on_end_time                 (end_time)
#  index_periods_on_name                     (name) UNIQUE
#  index_periods_on_start_time               (start_time)
#  index_periods_on_start_time_and_end_time  (start_time,end_time) UNIQUE
#

FactoryGirl.define do
  factory :period do
    name '1'
    start_time '09:00:00+09:00'
    end_time '10:30:00+09:00'

    Settings.period.each do |period_params|
      trait :"#{period_params.name.downcase}" do
        name period_params.name
        start_time period_params.start_time
        end_time period_params.end_time
      end
    end
  end
end
