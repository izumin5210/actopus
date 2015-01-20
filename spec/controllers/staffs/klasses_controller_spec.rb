require 'rails_helper'

RSpec.describe Staffs::KlassesController, type: :controller do
  sign_in_as_staff

  let(:klass) { create(:klass, :with_department) }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET timetable' do
    before { get :timetable, id: klass.id }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
