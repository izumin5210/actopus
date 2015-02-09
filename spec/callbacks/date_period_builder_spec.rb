require 'rails_helper'

RSpec.describe DatePeriodBuilder, type: :callback do
  let(:period_id_column) { :period_id }
  let(:taken_on_column) { :taken_on }
  let(:date_period_column) { :date_period }
  let(:date_period_setter) { :"#{date_period_column}=" }
  let(:callback) { DatePeriodBuilder.new(*attribute_names) }
  let(:attribute_names) { [period_id_column, taken_on_column, date_period_column] }
  let(:record) do
    double('record').tap do |r|
      attribute_names.each { |attr| allow(r).to receive(attr) }
    end
  end
  let(:period) { create(:period) }
  let(:taken_on) { Date.parse('2015-02-04') }

  describe '#before_validate' do
    subject { callback.before_validation(record) }

    context 'with no attributes' do
      it do
        expect(record).to_not receive(date_period_setter)
        subject
      end
    end

    context 'without taken_on' do
      it do
        allow(record).to receive(period_id_column).and_return(period.id)
        expect(record).to_not receive(date_period_setter)
        subject
      end
    end

    context 'without period_id' do
      it do
        allow(record).to receive(taken_on_column).and_return(taken_on)
        expect(record).to_not receive(date_period_setter)
        subject
      end
    end

    context 'with period and taken_on' do
      before do
        allow(record).to receive(period_id_column).and_return(period.id)
        allow(record).to receive(taken_on_column).and_return(taken_on)
      end

      it do
        expect(record).to receive(date_period_setter).with(kind_of(DatePeriod))
        subject
      end

      context 'when the date_period has already existed' do
        before { DatePeriod.create(taken_on: taken_on, period: period) }
        it do
          expect(record).to receive(date_period_setter).with(be_persisted)
          subject
        end
      end

      context 'when the date_period has not existed yet' do
        it do
          expect(record).to_not receive(date_period_setter).with(be_persisted)
          subject
        end
      end
    end
  end
end
