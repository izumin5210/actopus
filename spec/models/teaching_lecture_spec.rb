# == Schema Information
#
# Table name: teaching_lectures
#
#  id          :integer          not null, primary key
#  lecture_id  :integer          not null
#  lecturer_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_teaching_lectures_on_lecture_id_and_lecturer_id  (lecture_id,lecturer_id) UNIQUE
#

require 'rails_helper'

RSpec.describe TeachingLecture, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
