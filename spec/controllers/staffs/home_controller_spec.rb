require 'rails_helper'

RSpec.describe Staffs::HomeController, type: :controller do
  sign_in_as_staff

  describe 'GET home' do
    before { get :home }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
