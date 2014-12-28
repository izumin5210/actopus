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

RSpec.describe Period, type: :model do
  let(:period) { create(:period) }
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

  describe '.find_by_time' do
    before { load Rails.root.join('db/seeds/period.rb') }
    subject { Period.find_by_time(begin_at, end_at) }

    context 'with begin_at 09:00:00+09:00 and end_at 10:30:00+09:00' do
      let(:begin_at) { '09:00:00+09:00' }
      let(:end_at) { '10:30:00+09:00' }
      it { is_expected.to match_array Period.where(name: '1').to_a }
    end

    context 'with begin_at 10:40:00+09:00 and end_at 11:25:00+09:00' do
      let(:begin_at) { '10:40:00+09:00' }
      let(:end_at) { '11:25:00+09:00' }
      it { is_expected.to match_array Period.where(name: '2F').to_a }
    end

    context 'with begin_at 09:00:00+09:00 and end_at 12:10:00+09:00' do
      let(:begin_at) { '09:00:00+09:00' }
      let(:end_at) { '12:10:00+09:00' }
      it { is_expected.to match_array Period.where(name: %w(1 2)).to_a }
    end
  end
end
