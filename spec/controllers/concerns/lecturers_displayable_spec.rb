require 'rails_helper'

RSpec.describe LecturersDisplayable, type: :controller do
  controller(ApplicationController) do
    include LecturersDisplayable
    def index
      super
      render nothing: true
    end

    def timetable
      super
      render nothing: true
    end
  end

  before do
    routes.draw do
      get 'index' => 'anonymous#index'
      get 'timetable' => 'anonymous#timetable'
    end
  end

  it_behaves_like 'lecturers displayable'
end
