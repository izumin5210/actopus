class Staffs::TimetablesController < Staffs::BaseController
  def new
  end

  def create
    redirect_to new_staffs_timetable_path, notice: 'Not yet implemented.'
  end
end
