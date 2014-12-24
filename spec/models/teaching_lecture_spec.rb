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

RSpec.describe TeachingLecture, type: :model do
  let(:teaching_lecture) { create(:teaching_lecture) }
  subject { teaching_lecture }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:lecturer_id) }
    it do
      is_expected.to validate_uniqueness_of(:lecture_id).scoped_to(:lecturer_id)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:lecturer) }
  end
end
