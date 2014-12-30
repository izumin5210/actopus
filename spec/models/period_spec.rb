# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  start_time :string           not null
#  end_time   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_periods_on_end_time                 (end_time)
#  index_periods_on_name                     (name) UNIQUE
#  index_periods_on_start_time               (start_time)
#  index_periods_on_start_time_and_end_time  (start_time,end_time) UNIQUE
#

require 'rails_helper'

RSpec.describe Period, type: :model do
  let(:period) { create(:period) }
  subject { period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it do
      is_expected.to validate_uniqueness_of(:start_time).scoped_to(:end_time)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:wday_periods) }
    it { is_expected.to have_many(:schedulings) }
    it { is_expected.to have_many(:lectures).through(:schedulings) }
  end
end
