# == Schema Information
#
# Table name: lecturings
#
#  id          :integer          not null, primary key
#  lecture_id  :integer          not null
#  lecturer_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_lecturings_on_lecture_id_and_lecturer_id  (lecture_id,lecturer_id) UNIQUE
#

class Lecturing < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :lecturer

  validates :lecture_id, presence: true, uniqueness: { scope: [:lecturer_id] }
  validates :lecturer_id, presence: true
end
