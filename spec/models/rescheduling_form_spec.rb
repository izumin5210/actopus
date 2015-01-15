require 'rails_helper'

RSpec.describe ReschedulingForm, type: :model do
  let(:rescheduling_form) { ReschedulingForm.new(params) }
  let(:params) { {} }
  let(:lecture) { create(:lecture, :with_term, :with_klass) }
  let(:period) { create(:period) }
  subject { rescheduling_form }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
  end

  describe '#save' do
    subject { rescheduling_form.save }
    context 'with invalid params' do
      let(:params) do
        { category: 'cancel',
          before_period_id: period.id, before_date: Date.parse('2015-01-14') }
      end
      it { is_expected.to be false }
      it { expect { subject }.to_not change(lecture.reschedulings, :count) }
      it { expect { subject }.to_not change(Rescheduling, :count) }
      it { expect { subject }.to_not change(DatePeriod, :count) }
    end
    context 'when category is cancel' do
      let(:params) do
        { before_lecture_id: lecture.id, category: 'cancel',
          before_period_id: period.id, before_date: Date.parse('2015-01-14') }
      end
      it { is_expected.to be true }
      it { expect { subject }.to change(lecture.reschedulings, :count).by(1) }
      it { expect { subject }.to change(Rescheduling, :count).by(1) }
      it { expect { subject }.to change(DatePeriod, :count).by(1) }
    end
  end
end
