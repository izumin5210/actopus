require 'rails_helper'

RSpec.describe Staffs::LecturersController, type: :controller do
  sign_in_as_staff

  let(:lecturer) { create(:lecturer) }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET timetable' do
    before { get :timetable, id: lecturer.id }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
