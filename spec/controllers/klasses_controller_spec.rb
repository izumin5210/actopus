require 'rails_helper'

RSpec.describe KlassesController, type: :controller do
  let(:klass) { create(:klass, :with_department) }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET timetable' do
    before { get :timetable, id: klass.slug }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
