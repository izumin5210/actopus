class Staffs::LecturersController < Staffs::BaseController
  before_action :set_lecturer, only: %i(timetable update)

  include TimetableDisplayable

  def index
    @lecturers = Lecturer.all
  end

  def update
    if @lecturer.update(lecturer_params)
      redirect_to @lecturer, notice: 'Lecturer was successfully updated.'
    else
      render :edit
    end
  end

  private

  def lecturer_params
    params.require(:lecturer).permit(:department_id)
  end

  def set_lecturer
    @lecturer = Lecturer.find(params[:id])
  end

  def set_lectures
    @lectures = @lecturer.lectures
      .includes(:klass, :lecturers, wday_periods: [:period])
  end
end
