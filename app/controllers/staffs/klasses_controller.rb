class Staffs::KlassesController < Staffs::BaseController
  before_action :set_klass, only: %i(timetable)

  def index
    @klasses = Klass.includes(:department).all
  end

  def timetable
    @timeline = LectureTimeline.new(@klass.lectures)
  end

  private

  def set_klass
    @klass = Klass.find(params[:id])
  end
end
