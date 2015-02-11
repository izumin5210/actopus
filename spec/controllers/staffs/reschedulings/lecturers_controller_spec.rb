require 'rails_helper'

RSpec.describe Staffs::Reschedulings::LecturersController, type: :controller do
  sign_in_as_staff

  it_behaves_like 'lecturers index displayable' do
    let(:params) { { category: :change } }
  end

  it_behaves_like 'lecturers timetable displayable' do
    let(:params) { { id: lecturer.id, category: :change } }
  end
end
