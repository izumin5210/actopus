require 'rails_helper'

RSpec.describe TimetableDisplayable, type: :controller do
  before do
    term = create(:academic_term)
    create_list(:lecture, 3, :with_klass, term: term)
    Timecop.freeze(Time.local(2015, 1, 19, 12, 0, 0))
  end

  after { Timecop.return }
  let(:params) { nil }

  describe 'GET timetable' do
    pending 'Not yet implemented.'
  end
end
