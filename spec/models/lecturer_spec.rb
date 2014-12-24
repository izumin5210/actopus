# == Schema Information
#
# Table name: lecturers
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  department_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Lecturer, type: :model do
  let(:lecturer) { create(:lecturer) }
  subject { lecturer }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:department_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:department) }
  end
end
