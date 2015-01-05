class DatePeriod < ActiveRecord::Base
  belongs_to :period
  belongs_to :rescheduling

  validates :period_id, presence: true
  validates :date_on, presence: true
end
