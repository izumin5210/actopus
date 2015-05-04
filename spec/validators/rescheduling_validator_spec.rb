require 'rails_helper'

RSpec.describe ReschedulingValidator, type: :validator do
  let(:attribute_names) { %i(category before_date_period after_date_period) }
  let(:today) { Date.parse('2015-01-13').tap { |d| Timecop.travel(d) } }
  let(:before_date_period) { create(:date_period, taken_on: today + 2.days) }
  let(:after_date_period) { create(:date_period, taken_on: today + 7.days) }

  describe '#validate' do
    context 'when the category is cancel' do
      let(:category) { 'cancel' }
      let(:after_date_period) { nil }
      context 'without before_date_period' do
        let(:before_date_period) { nil }
        it { is_expected.to_not be_valid }
      end
      context 'with before_date_period' do
        it { is_expected.to be_valid }
      end
    end

    context 'when the category is addition' do
      let(:category) { 'addition' }
      let(:before_date_period) { nil }
      context 'without after_date_period' do
        let(:after_date_period) { nil }
        it { is_expected.to_not be_valid }
      end
      context 'with after_date_period' do
        it { is_expected.to be_valid }
      end
    end
  end
end
