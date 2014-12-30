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

  validates :period_id, presence: true, uniqueness: { scope: [:wday] }
  validates :wday, presence: true
end
