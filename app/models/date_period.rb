# == Schema Information
#
# Table name: date_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer
#  taken_on   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DatePeriod < ActiveRecord::Base
  belongs_to :period
  has_many :before_reschedulings,
    class_name: 'Rescheduling', foreign_key: :before_date_period_id
  has_many :after_reschedulings,
    class_name: 'Rescheduling', foreign_key: :after_date_period_id

  validates :period_id, presence: true
  validates :taken_on, presence: true
end
