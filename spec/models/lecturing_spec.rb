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

require 'rails_helper'

RSpec.describe Lecturing, type: :model do
  let(:lecturing) { Lecturing.new }
  subject { lecturing }

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:lecturer) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:lecturer_id) }
    describe 'uniqueness' do
      let(:lecturing) { create(:lecturing) }
      it do
        is_expected.to validate_uniqueness_of(:lecture_id)
          .scoped_to(:lecturer_id)
      end
    end
  end
end
