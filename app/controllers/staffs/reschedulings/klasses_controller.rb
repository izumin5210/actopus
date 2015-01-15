class Staffs::Reschedulings::KlassesController < Staffs::KlassesController
  before_action :set_rescheduling, only: %i(timetable)

  def set_rescheduling
    @form = ReschedulingForm.new(category: params[:category],
      before_lecture_id: params[:lecture_id],
      before_period_id: params[:before_period_id],
      before_date: params[:before_date])
  end
end
