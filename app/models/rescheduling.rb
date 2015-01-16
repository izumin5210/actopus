# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Rescheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :before_date_period, class_name: 'DatePeriod'
  belongs_to :after_date_period, class_name: 'DatePeriod'

  validates :lecture_id, presence: true
  validates :category, presence: true

  enum category: Settings.rescheduling.category
end
