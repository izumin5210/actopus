class LecturersController < ApplicationController
  before_action :set_lecturer, only: %i(timetable update)

  include TimetableDisplayable

  def index
    @lecturers = Lecturer.all.group_by(&:department_id)
    @department = Department.all
  end

  private

  def set_lecturer
    @lecturer = Lecturer.find(params[:id])
  end

  def set_lectures
    @lectures = @lecturer.lectures
      .includes(:klass, :lecturers, wday_periods: [:period])
  end
end
