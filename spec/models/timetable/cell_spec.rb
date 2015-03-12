require 'rails_helper'

RSpec.describe Timetable::Cell, type: :model do
  let(:lecture) { create(:lecture, :with_term, :with_klass) }
  let(:period) { create(:period) }
  let(:taken_on) { Date.today }
  let(:cell) do
    Timetable::Cell.new(lecture: lecture, period: period, taken_on: taken_on)
  end

  subject { cell }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:lecture) }
    it { is_expected.to validate_presence_of(:period) }
    it { is_expected.to validate_presence_of(:taken_on) }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:start_time).to(:period) }
    it { is_expected.to delegate_method(:end_time).to(:period) }
    it do
      is_expected.to delegate_method(:category).to(:rescheduling).with_prefix
    end
  end

  describe '#initialize' do
    before do
      create(:rescheduling, :cancel,
             lecture: lecture, period: period, taken_on: taken_on.yesterday)
      create(:rescheduling, :cancel,
             lecture: lecture, period: create(:period), taken_on: taken_on)
    end

    context 'when cancelled reschedulings does not exist' do
      it 'has no rescheduling objects' do
        expect(cell.rescheduling).to be_blank
      end
    end

    context 'when added rescheduling exists' do
      let!(:rescheduling) do
        create(:rescheduling, :addition,
               lecture: lecture, period: period, taken_on: taken_on)
      end

      it 'has no rescheduling objects' do
        expect(cell.rescheduling).to be_blank
      end
    end

    context 'when cancelled reschedulings exists' do
      let!(:rescheduling) do
        create(:rescheduling, :cancel,
               lecture: lecture, period: period, taken_on: taken_on)
      end

      it 'contains only cancel reschedulings' do
        expect(cell.rescheduling.category).to eq 'cancel'
      end

      it 'contains only reschedulings which will be taken on the same day' do
        expect(cell.rescheduling.taken_on).to eq rescheduling.taken_on
      end

      it 'contains only reschedulings which will be taken on the same period' do
        expect(cell.rescheduling.period_id).to eq rescheduling.period_id
      end

      it 'has a rescheduling object' do
        expect(cell.rescheduling).to be_present
      end
    end
  end
end
