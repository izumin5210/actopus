require 'rails_helper'

RSpec.describe Staffs::Reschedulings::LecturersController, type: :controller do
  sign_in_as_staff

  describe 'GET index' do
    before { get :index, category: :change }

    it 'assings all lecturers to @lecturers' do
      expect(assigns(:lecturers)).to all(be_a(Lecturer))
    end

    it 'assings all departments to @departments' do
      expect(assigns(:departments)).to all(be_a(Department))
    end
  end
end
