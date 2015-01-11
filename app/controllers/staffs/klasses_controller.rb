class Staffs::KlassesController < Staffs::BaseController
  before_action :set_klass, only: %i(timetable)

  def index
    @klasses = Klass.includes(:department).all
  end

  def timetable
    lectures = @klass.lectures.includes(:lecturers, wday_periods: [:period])
    @timeline = LectureTimeline.new(lectures)
  end

  private

  def set_klass
    @klass = Klass.find(params[:id])
  end
end
