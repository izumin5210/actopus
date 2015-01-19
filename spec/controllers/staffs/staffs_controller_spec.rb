require 'rails_helper'

RSpec.describe Staffs::StaffsController, type: :controller do
  sign_in_as_staff

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST invite' do
    let(:params) { { staff: attributes_for(:staff) } }
    after { ActionMailer::Base.deliveries.clear }
    it 'returns http found' do
      post :invite, params
      expect(response).to have_http_status(:found)
    end
    it 'saves the new staff in the database' do
      expect { post :invite, params }.to change(Staff, :count).by(1)
    end
    it 'sends the invite mail to the new staff' do
      expect {
        post :invite, params
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end
