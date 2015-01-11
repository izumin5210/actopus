class Staffs::LecturersController < Staffs::BaseController
  before_action :set_lecturer, only: %i(timetable)

  def index
    @lecturers = Lecturer.all
  end

  def timetable
    @timeline = LectureTimeline.new(@lecturer.lectures)
  end

  private

  def set_lecturer
    @lecturer = Lecturer.find(params[:id])
  end
end
