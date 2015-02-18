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
    it 'assigns all periods to @periods' do
      expect(assigns(:periods)).to all(be_a Period)
    end

    context 'with no params' do
      it 'assigns a new ReschedulingForm to @form' do
        expect(assigns(:rescheduling)).to be_a_new(Rescheduling)
      end
    end
  end
end
