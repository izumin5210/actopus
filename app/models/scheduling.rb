# == Schema Information
#
# Table name: schedulings
#
#  id             :integer          not null, primary key
#  lecture_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  wday_period_id :integer          not null
#
# Indexes
#
#  index_schedulings_on_lecture_id_and_wday_period_id  (lecture_id,wday_period_id) UNIQUE
#

class Scheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :wday_period

  validates :lecture_id, presence: true, uniqueness: { scope: [:wday_period_id] }
  validates :wday_period_id, presence: true
end
