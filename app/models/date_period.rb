# == Schema Information
#
# Table name: date_periods
#
#  id             :integer          not null, primary key
#  period_time_id :integer
#  taken_on       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class DatePeriod < ActiveRecord::Base
  belongs_to :period_time
  has_many :before_reschedulings,
    class_name: 'Rescheduling', foreign_key: :before_date_period_id
  has_many :after_reschedulings,
    class_name: 'Rescheduling', foreign_key: :after_date_period_id

  validates :period_time_id, presence: true
  validates :taken_on, presence: true

  delegate :start_time, :end_time, to: :period_time

  include Garage::Representer

  property :start_time
  property :end_time
  property :taken_on_str, as: :taken_on

  def taken_on_str
    taken_on.strftime('%Y-%m-%d')
  end
end
