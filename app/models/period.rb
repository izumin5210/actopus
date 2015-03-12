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

class Period < ActiveRecord::Base
  has_many :date_periods
  has_many :wday_periods

  validates :name, presence: true, uniqueness: true
  validates :start_time, presence: true, uniqueness: { scope: [:end_time] }
  validates :end_time, presence: true

  attr_accessor :taken_on

  include Garage::Representer

  property :start_time
  property :end_time
  property :taken_on, if: -> (record, _) { record.taken_on.present? }

  include Comparable

  def is?(params)
    (params[:start_time] == start_time) && (params[:end_time] == end_time)
  end

  def length
    Time.parse(end_time) - Time.parse(start_time)
  end

  def <=>(other)
    result = Time.parse(start_time) <=> Time.parse(other.start_time)
    result == 0 ? Time.parse(end_time) <=> Time.parse(other.end_time) : result
  end

  def taken_on=(date)
    @taken_on = date.to_s
  end
end
