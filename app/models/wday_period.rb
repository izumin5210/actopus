# == Schema Information
#
# Table name: wday_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer          not null
#  wday       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wday_periods_on_period_id           (period_id)
#  index_wday_periods_on_period_id_and_wday  (period_id,wday) UNIQUE
#  index_wday_periods_on_wday                (wday)
#

class WdayPeriod < ActiveRecord::Base
  belongs_to :period
  has_many :schedulings
  has_many :lectures, through: :schedulings

  validates :period_id, presence: true, uniqueness: { scope: [:wday] }
  validates :wday, presence: true

  delegate :start_time, :end_time, to: :period

  include Garage::Representer

  property :wday
  property :start_time
  property :end_time

  def is?(params)
    (params[:wday] == wday) &&
      (params[:start_time] == start_time) &&
      (params[:end_time] == end_time)
  end

  def to_date_period(date)
    DatePeriod.find_or_initialize_by(
      period: period, taken_on: date.beginning_of_week + (wday - 1).days)
  end
end
