# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Rescheduling < ActiveRecord::Base
  belongs_to :lecture

  has_many :date_periods

  validates :lecture_id, presence: true
  validates :before_date_period_id, presence: true
  validates :after_date_period_id, presence: true
  validates :category, presence: true
end
