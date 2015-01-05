class DatePeriod < ActiveRecord::Base
  belongs_to :period
  has_many :before_reschedulings,
    class_name: 'Rescheduling', foreign_key: :before_date_period_id
  has_many :after_reschedulings,
    class_name: 'Rescheduling', foreign_key: :after_date_period_id

  validates :period_id, presence: true
  validates :date_on, presence: true
end
