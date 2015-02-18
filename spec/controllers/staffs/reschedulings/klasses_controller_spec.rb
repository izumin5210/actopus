require 'rails_helper'

RSpec.describe Staffs::Reschedulings::KlassesController, type: :controller do
  sign_in_as_staff

  it_behaves_like 'klasses index displayable'

  it_behaves_like 'klasses timetable displayable' do
    let(:params) { { id: klasses[0].slug } }
  end
end
