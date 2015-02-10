require 'rails_helper'

RSpec.describe Staffs::Reschedulings::KlassesController, type: :controller do
  sign_in_as_staff

  it_behaves_like 'klasses index displayable' do
    let(:params) do
      { category: :change }
    end
  end

  it_behaves_like 'klasses timetable displayable' do
    let(:params) do
      { id: klasses[0].slug, category: :change }
    end
  end
end
