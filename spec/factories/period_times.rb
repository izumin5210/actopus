# == Schema Information
#
# Table name: period_times
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
#  index_period_times_on_end_time                 (end_time)
#  index_period_times_on_name                     (name) UNIQUE
#  index_period_times_on_start_time               (start_time)
#  index_period_times_on_start_time_and_end_time  (start_time,end_time) UNIQUE
#

FactoryGirl.define do
  factory :period_time do
    sequence(:name) { |n| "#{n}限" }
    sequence(:start_time) do |n|
      (Time.parse('09:00:00+09:00') + (15 * n).minutes).strftime('%H:%M:%S%:z')
    end
    sequence(:end_time) do |n|
      (Time.parse('10:30:00+09:00') + (15 * n).minutes).strftime('%H:%M:%S%:z')
    end
  end
end
