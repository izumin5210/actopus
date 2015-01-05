class DatePeriod < ActiveRecord::Base
  belongs_to :period
  belongs_to :rescheduling
end
