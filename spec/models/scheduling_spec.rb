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

require 'rails_helper'

RSpec.describe Scheduling, type: :model do
  let(:scheduling) { Scheduling.new }
  subject { scheduling }

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:wday_period) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:wday_period_id) }
    describe 'uniqueness' do
      let(:scheduling) { create(:scheduling) }
      it do
        is_expected.to(
          validate_uniqueness_of(:lecture_id).scoped_to(:wday_period_id))
      end
    end
  end
end
