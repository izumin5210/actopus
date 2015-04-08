require 'rails_helper'

RSpec.describe ReschedulingForm, type: :model do
  let(:rescheduling_form) { ReschedulingForm.new(params) }
  let(:lecture) { create(:lecture) }
  let(:period_time) { create(:period_time) }
  subject { rescheduling_form }

  let(:params) do
    { lecture_id: lecture.id, category: category,
      before_period_id: before_period_time.try(:id), before_date: before_date,
      after_period_id: after_period_time.try(:id), after_date: after_date
    }
  end
  let(:category) { 'cancel' }
  let(:before_period_time) { period_time }
  let(:after_period_time) { create(:period_time) }
  let(:before_date) { Date.parse('2015-01-14') }
  let(:after_date) { Date.parse('2015-01-22') }

  shared_examples_for 'a invalid rescheduling form' do
    it { is_expected.to be false }
    it { expect { subject }.to_not change(lecture.reschedulings, :count) }
    it { expect { subject }.to_not change(Rescheduling, :count) }
    it { expect { subject }.to_not change(DatePeriod, :count) }
  end

  shared_examples_for 'a valid rescheduling form' do
    it { is_expected.to be true }
    it { expect { subject }.to change(lecture.reschedulings, :count).by(1) }
    it { expect { subject }.to change(Rescheduling, :count).by(1) }
    it do
      expect { subject }
        .to change(DatePeriod, :count).by(a_value_within(1).of(2))
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
  end

  describe '#save' do
    subject { rescheduling_form.save }
    it_behaves_like 'a invalid rescheduling form' do
      let(:category) { 'pyonpyon' }
    end
    context 'when category is "cancel"' do
      let(:category) { 'cancel' }
      let(:after_period_time) { nil }
      let(:after_date) { nil }
      it_behaves_like 'a invalid rescheduling form' do
        let(:before_period_time) { nil }
      end
      it_behaves_like 'a valid rescheduling form'
    end

    context 'when category is "change"' do
      let(:category) { 'change' }
      it_behaves_like 'a invalid rescheduling form' do
        let(:after_period_time) { nil }
      end
      it_behaves_like 'a valid rescheduling form'
    end

    context 'when category is "extra"' do
      let(:category) { 'extra' }
      let(:before_period_time) { nil }
      let(:before_date) { nil }
      it_behaves_like 'a invalid rescheduling form' do
        let(:after_period_time) { nil }
      end
      it_behaves_like 'a valid rescheduling form'
    end
  end
end
