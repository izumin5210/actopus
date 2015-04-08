require 'rails_helper'

RSpec.describe ReschedulingsCreatable, type: :controller do
  controller(ApplicationController) do
    include ReschedulingsCreatable

    def timetable
      render nothing: true
    end
  end

  before do
    routes.draw { get 'timetable' => 'anonymous#timetable' }
    get :timetable
  end

  describe 'GET timetable' do
    it 'assigns all period_times to @period_times' do
      expect(assigns(:period_times)).to all(be_a PeriodTime)
    end

    context 'with no params' do
      it 'assigns a new ReschedulingForm to @form' do
        expect(assigns(:form)).to be_a(ReschedulingForm)
      end
    end
  end
end
