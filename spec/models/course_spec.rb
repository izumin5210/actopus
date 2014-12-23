# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_courses_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_courses_on_name               (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create(:course) }
  subject { course }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:abbreviation_name) }
    it { is_expected.to validate_uniqueness_of(:abbreviation_name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:lectures) }
  end
end
