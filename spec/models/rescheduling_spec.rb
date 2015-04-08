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

  describe 'available' do
    let(:period_time) { create(:period_time) }
    let(:today) { Time.local(2015, 1, 19, 12, 0, 0) }
    let(:today_date_period) do
      create(:date_period, period_time: period_time, taken_on: today)
    end
    let(:yesterday_date_period) do
      create(:date_period, period_time: period_time, taken_on: today.yesterday)
    end
    let(:lecture) { create(:lecture) }
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
    it { is_expected.to match_array(reschedulings[1, 2]) }
    it { expect(subject.size).to eq 2 }
  end
end
