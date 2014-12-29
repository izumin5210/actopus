class Staffs::TimetablesController < Staffs::BaseController
  def new
    @form = TimetableForm.new
  end

  def create
    @form = TimetableForm.new(timetable_params)
    @form.save
    redirect_to new_staffs_timetable_path, notice: 'Not yet implemented.'
  end

  private

  def timetable_params
    params.require(:timetable_form)
      .permit(:name, :start_on, :end_on, :timetable_xml)
  end
end
