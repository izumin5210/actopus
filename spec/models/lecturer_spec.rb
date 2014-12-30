# == Schema Information
#
# Table name: lecturers
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Lecturer, type: :model do
  let(:lecturer) { create(:lecturer) }
  subject { lecturer }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to have_many(:lecturings) }
    it { is_expected.to have_many(:lectures).through(:lecturings) }
  end
end
