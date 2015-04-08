module LecturersDisplayable
  extend ActiveSupport::Concern
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
    set_lecturer
    @lectures =
      @lecturer.lectures.current_term
      .includes(:klass, :lecturers, periods: [:period])
  end
end
