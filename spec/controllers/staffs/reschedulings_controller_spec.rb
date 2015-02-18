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
    let(:lecture) { create(:lecture, :with_term, :with_klass) }
    let(:period) { create(:period) }
    let(:date) { Date.new(2015, 1, 19) }
    before { Timecop.freeze(date - 10.days) }
    after { Timecop.return }
    let(:params) do
      { category: 'cancel',
        lecture_id: lecture.id,
        period_id: period.id,
        taken_on: date
      }
    end
    subject { post :create, rescheduling: params }

    it 'returns http found' do
      subject
      expect(response).to have_http_status(:found)
    end

    it 'save the new rescheduling' do
      expect { subject }.to change(Rescheduling, :count).by(1)
    end
  end
end
