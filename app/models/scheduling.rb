# == Schema Information
#
# Table name: schedulings
#
#  id         :integer          not null, primary key
#  lecture_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  period_id  :integer          not null
#
# Indexes
#
#  index_schedulings_on_lecture_id_and_period_id  (lecture_id,period_id) UNIQUE
#

class Scheduling < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :period

  validates :lecture_id, presence: true, uniqueness: { scope: [:period_id] }
  validates :period_id, presence: true
end
