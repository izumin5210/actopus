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

FactoryGirl.define do
  factory :lecturing do
    lecture
    lecturer { create(:lecturer, department: lecture.department) }
  end
end
