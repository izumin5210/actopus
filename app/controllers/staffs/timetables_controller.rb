class Staffs::TimetablesController < Staffs::BaseController
  def index
    lectures = Lecture.includes(:department, :course, wday_periods: :period).where(grade: 1)
    grouped_lectures = lectures.group_by do |l|
        "#{l.grade}#{l.department.abbreviation_name}#{l.course.try(:abbreviation_name)}"
      end
    @timelines = LectureTimeline.parse(grouped_lectures)
  end

  def new
    @form = TimetableForm.new
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
