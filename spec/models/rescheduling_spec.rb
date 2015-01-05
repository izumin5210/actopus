# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Rescheduling, :type => :model do
  let(:rescheduling) { build(:rescheduling) }
  subject { rescheduling }

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:before_date_period).class_name('DatePeriod') }
    it { is_expected.to belong_to(:after_date_period).class_name('DatePeriod') }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:before_date_period_id) }
    it { is_expected.to validate_presence_of(:after_date_period_id) }
    it { is_expected.to validate_presence_of(:category) }
  end
end
