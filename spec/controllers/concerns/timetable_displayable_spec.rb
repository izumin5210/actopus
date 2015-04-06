require 'rails_helper'

RSpec.describe TimetableDisplayable, type: :controller do
  create_term_and_freeze_time

  before { create_list(:lecture, 3, term: term) }
  let(:params) { nil }

  describe 'GET timetable' do
    subject { get :timetable, params }
    context 'when the subclass does not override #set_lectures' do
      controller(ApplicationController) do
        include TimetableDisplayable
      end
      before { routes.draw { get 'timetable' => 'anonymous#timetable' } }
      it { expect { subject }.to raise_error(NotImplementedError) }
    end

    context 'when the subclass overrides #set_lectures' do
      controller(ApplicationController) do
        include TimetableDisplayable
        def timetable
          super
          render nothing: true
        end
        def set_lectures
          @lectures = Lecture.all
        end
      end
      before { routes.draw { get 'timetable' => 'anonymous#timetable' } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      context 'with the date param' do
        let(:params) { { date: Date.new(2015, 1, 12) } }
        it 'assigns the week of the date to @date_step' do
          subject
          expect([*assigns(:date_step)]).to(
            starting_with(Date.new(2015, 1, 12))
              .and(ending_with(Date.new(2015, 1, 18)))
          )
        end
      end
    end
  end
end
