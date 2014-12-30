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
  has_many :held_lectures
  has_many :lectures, through: :held_lectures
  has_many :wday_periods

  validates :name, presence: true, uniqueness: true
  validates :start_time, presence: true, uniqueness: { scope: [:end_time] }
  validates :end_time, presence: true
end
