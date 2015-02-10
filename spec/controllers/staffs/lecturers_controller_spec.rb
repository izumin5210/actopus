require 'rails_helper'

RSpec.describe Staffs::LecturersController, type: :controller do
  sign_in_as_staff

  describe 'GET index' do
    let!(:lecturers) { create_list(:lecturer, 5, :with_department) }

    before { get :index }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns lecturers grouped by department ids to @lecturers' do
      expect(assigns(:lecturers)).to match(lecturers)
    end
  end

  it_behaves_like 'lecturers timetable displayable' do
    let(:params) { { id: lecturer.id, category: :change } }
  end
end
