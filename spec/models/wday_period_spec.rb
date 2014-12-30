# == Schema Information
#
# Table name: wday_periods
#
#  id         :integer          not null, primary key
#  period_id  :integer          not null
#  wday       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wday_periods_on_period_id           (period_id)
#  index_wday_periods_on_period_id_and_wday  (period_id,wday) UNIQUE
#  index_wday_periods_on_wday                (wday)
#

require 'rails_helper'

RSpec.describe WdayPeriod, type: :model do
  let(:wday_period) { create(:wday_period) }
  subject { wday_period }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:period_id) }
    it { is_expected.to validate_presence_of(:wday) }
    it do
      is_expected.to validate_uniqueness_of(:period_id).scoped_to(:wday)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:period) }
  end
end
