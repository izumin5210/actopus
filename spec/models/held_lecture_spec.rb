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

require 'rails_helper'

RSpec.describe HeldLecture, type: :model do
  let(:held_lecture) { FactoryGirl.create(:held_lecture) }
  subject { held_lecture }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:wday) }
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:period_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:period) }
  end
end
