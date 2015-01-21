class KlassesController < ApplicationController
  before_action :set_klass, only: %i(timetable)

  include TimetableDisplayable

  def index
    @klasses = Klass.includes(:department).all
  end

  private

  def set_klass
    @klass = Klass.friendly.find(params[:id])
  end

  def set_lectures
    @lectures = @klass.lectures.includes(:lecturers, wday_periods: [:period])
  end
end
