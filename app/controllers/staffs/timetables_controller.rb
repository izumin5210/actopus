class Staffs::TimetablesController < Staffs::BaseController
  def new
    @form = TimetableForm.new
  end

  def show
    klass = Klass.find(params[:id])
    @timeline = LectureTimeline.new(klass.lectures)
  end

  def create
    @form = TimetableForm.new(timetable_params)
    if @form.valid? && @form.save
      count = @form.count
      msg = "Added #{count[:lecture]} #{'lecture'.pluralize(count[:lecture])} and #{count[:lecturer]} #{'lecturer'.pluralize(count[:lecturer])}"
      redirect_to new_staffs_timetable_path, notice: msg
    else
      render :new, alert: 'Update faild.'
    end
  end

  private

  def timetable_params
    params.require(:timetable_form)
      .permit(:name, :started_on, :ended_on, :timetable_xml)
  end
end
