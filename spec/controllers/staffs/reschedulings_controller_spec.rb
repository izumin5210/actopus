require 'rails_helper'

RSpec.describe Staffs::ReschedulingsController, type: :controller do
  sign_in_as_staff

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
