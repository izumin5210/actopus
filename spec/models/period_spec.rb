# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  begin_at   :string           not null
#  end_at     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_periods_on_begin_at_and_end_at  (begin_at,end_at) UNIQUE
#  index_periods_on_name                 (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Period, :type => :model do
  let(:period) { FactoryGirl.create(:period) }
  subject { period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:begin_at) }
    it { is_expected.to validate_presence_of(:end_at) }
    it { is_expected.to validate_uniqueness_of(:begin_at).scoped_to(:end_at) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:held_lectures) }
    it { is_expected.to have_many(:lectures).through(:held_lectures) }
  end
end
