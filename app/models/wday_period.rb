# == Schema Information
#
# Table name: wday_periods
#
#  id             :integer          not null, primary key
#  period_time_id :integer          not null
#  wday           :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_wday_periods_on_period_time_id           (period_time_id)
#  index_wday_periods_on_period_time_id_and_wday  (period_time_id,wday) UNIQUE
#  index_wday_periods_on_wday                     (wday)
#

class WdayPeriod < ActiveRecord::Base
  belongs_to :period_time
  has_many :schedulings
  has_many :lectures, through: :schedulings

  validates :period_time_id, presence: true, uniqueness: { scope: [:wday] }
  validates :wday, presence: true

  delegate :start_time, :end_time, to: :period_time

  include Garage::Representer

  property :wday
  property :start_time
  property :end_time

  def is?(params)
    (params[:wday] == wday) &&
      (params[:start_time] == start_time) &&
      (params[:end_time] == end_time)
  end
end
