require 'rails_helper'

RSpec.describe Staffs::ReschedulingsController, type: :controller do
  sign_in_as_staff

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    let(:lecture) { create(:lecture) }
    let(:before_period) { create(:period) }
    let(:after_period) { create(:period) }
    let(:before_date) { Date.new(2015, 1, 19) }
    let(:after_date) { Date.new(2015, 1, 22) }
    before { Timecop.freeze(Time.local(2015, 1, 19, 12, 0, 0)) }
    after { Timecop.return }
    let(:params) do
      { category: 'change',
        lecture_id: lecture.id,
        before_period_id: before_period.id,
        after_period_id: after_period.id,
        before_date: before_date,
        after_date: after_date
      }
    end
    subject { post :create, rescheduling_form: params }

    it 'returns http found' do
      subject
      expect(response).to have_http_status(:found)
    end

    it 'save the new rescheduling' do
      expect { subject }.to change(Rescheduling, :count).by(1)
    end
  end
end
