# == Schema Information
#
# Table name: departments
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  abbreviation_name :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_departments_on_abbreviation_name  (abbreviation_name) UNIQUE
#  index_departments_on_name               (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Department, type: :model do
  let(:department) { FactoryGirl.create(:department) }
  subject { department }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:abbreviation_name) }
    it { is_expected.to validate_uniqueness_of(:abbreviation_name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:lectures) }
    it { is_expected.to have_many(:lecturers) }
  end
end
