# == Schema Information
#
# Table name: reschedulings
#
#  id                    :integer          not null, primary key
#  lecture_id            :integer
#  before_date_period_id :integer
#  after_date_period_id  :integer
#  category              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Rescheduling, type: :model do
  let(:rescheduling) { Rescheduling.new }
  subject { rescheduling }

  describe 'associations' do
    it { is_expected.to belong_to(:lecture) }
    it { is_expected.to belong_to(:before_date_period).class_name('DatePeriod') }
    it { is_expected.to belong_to(:after_date_period).class_name('DatePeriod') }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lecture_id) }
    it { is_expected.to validate_presence_of(:category) }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:klass).to(:lecture) }
    it { is_expected.to delegate_method(:lecturers).to(:lecture) }
  end

  describe 'enums' do
    it do
      is_expected.to(define_enum_for(:category)
        .with(Settings.rescheduling.category.keys))
    end
  end

  describe '.join_before_date_period' do
    subject { Rescheduling.join_before_date_period }
    it do
      expect(subject.to_sql).to match(
        /LEFT OUTER JOIN "date_periods" "before_date_period"/)
    end
  end

  describe '.join_after_date_period' do
    subject { Rescheduling.join_after_date_period }
    it do
      expect(subject.to_sql).to match(
        /LEFT OUTER JOIN "date_periods" "after_date_period"/)
    end
  end

  describe '.available' do
    let(:period) { create(:period) }
    let(:today) { Time.local(2015, 1, 19, 12, 0, 0) }
    let(:today_date_period) do
      create(:date_period, period: period, taken_on: today)
    end
    let(:yesterday_date_period) do
      create(:date_period, period: period, taken_on: today.yesterday)
    end
    let(:lecture) { create(:lecture, :with_term, :with_klass) }
    let!(:reschedulings) do
      [
        create(:rescheduling,
               category: :cancel,
               before_date_period: yesterday_date_period,
               after_date_period: nil,
               lecture: lecture),
        create(:rescheduling,
               category: :cancel,
               before_date_period: today_date_period,
               after_date_period: nil,
               lecture: lecture),
        create(:rescheduling,
               category: :change,
               before_date_period: yesterday_date_period,
               after_date_period: today_date_period,
               lecture: lecture)
      ]
    end
    before do
      Timecop.freeze(today)
    end
    subject { Rescheduling.available }
    after { Timecop.return }
    it 'returns available reschedulings' do
      is_expected.to match_array(reschedulings[1, 2])
    end
    it 'returns 4 reschedulings' do
      expect(subject.size).to eq 2
    end
  end

  describe '.on' do
    let(:period) { create(:period) }
    let(:today) { Time.local(2015, 1, 19, 12, 0, 0) }
    let(:today_date_period) do
      create(:date_period, period: period, taken_on: today)
    end
    let(:yesterday_date_period) do
      create(:date_period, period: period, taken_on: today.yesterday)
    end
    let(:lecture) { create(:lecture, :with_term, :with_klass) }
    let!(:reschedulings) do
      [
        create(:rescheduling,
               category: :cancel,
               before_date_period: yesterday_date_period,
               after_date_period: nil,
               lecture: lecture),
        create(:rescheduling,
               category: :cancel,
               before_date_period: today_date_period,
               after_date_period: nil,
               lecture: lecture),
        create(:rescheduling,
               category: :change,
               before_date_period: yesterday_date_period,
               after_date_period: today_date_period,
               lecture: lecture)
      ]
    end
    subject { Rescheduling.on(today_date_period) }
    it 'returns reschedulings that will be taken on the date' do
      is_expected.to contain_exactly(*reschedulings[1, 2])
    end
    it 'returns 2 reschedulings' do
      expect(subject.size).to eq 2
    end
  end

  describe '.before_date_period_arel_table' do
    subject { Rescheduling.before_date_period_arel_table }
    it { is_expected.to be_a(Arel::Nodes::TableAlias) }
    it { expect(subject.to_sql).to match /"date_periods" "before_date_period"/ }
  end

  describe '.after_date_period_arel_table' do
    subject { Rescheduling.after_date_period_arel_table }
    it { is_expected.to be_a(Arel::Nodes::TableAlias) }
    it { expect(subject.to_sql).to match /"date_periods" "after_date_period"/ }
  end
end
