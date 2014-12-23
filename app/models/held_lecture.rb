# == Schema Information
#
# Table name: held_lectures
#
#  id         :integer          not null, primary key
#  lecture_id :integer          not null
#  period_id  :integer          not null
#  wday       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_held_lectures_on_lecture_id_and_period_id_and_wday  (lecture_id,period_id,wday) UNIQUE
#

class HeldLecture < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :period

  validates :lecture_id, presence: true
  validates :period_id, presence: true
  validates :wday, presence: true
end
