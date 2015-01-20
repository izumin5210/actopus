require 'rails_helper'

RSpec.describe Staffs::TimetablesController, type: :controller do
  sign_in_as_staff

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    before do
      periods_params =
        [
          { name: '1限',
            start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' },
          { name: '3限',
            start_time: '13:00:00+09:00', end_time: '14:30:00+09:00' },
          { name: '4限',
            start_time: '14:40:00+09:00', end_time: '16:10:00+09:00' }
        ]
      periods_params.each { |period_params| create(:period, period_params) }
      e = create(:department, name: '電気情報工学科', abbreviation_name: 'E')
      j = create(:course, name: '情報工学コース', abbreviation_name: 'J')
      create(:klass, name: '1E', grade: 1, department: e)
      create(:klass, name: '4EJ', grade: 4, department: e, course: j)
    end
    let(:timetable_xml) do
      fixture_file_upload('files/timetable_sample.xml', 'text/xml')
    end
    let(:params) do
      { name: '2014年度後期', started_on: '2014-10-01', ended_on: '2015-02-28',
        timetable_xml: timetable_xml
      }
    end
    subject { post :create, timetable_form: params }
    context 'with valid parameters' do
      it 'saves the new term' do
        expect { subject }.to change(Term, :count).by(1)
      end

      it 'redirects to staffs/timetables#new' do
        subject
        expect(response).to redirect_to new_staffs_timetable_path
      end
    end

    context 'with invalid parameters' do
      let(:params) { { name: 'invalid timetable' } }
      it 'does not save the new term' do
        expect { subject }.to_not change(Term, :count)
      end

      it 're-renders the :new template' do
        subject
        expect(response).to render_template :new
      end
    end
  end
end
