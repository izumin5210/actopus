class Staffs::Reschedulings::KlassesController < Staffs::KlassesController
  before_action :set_rescheduling, only: %i(timetable)

  def set_rescheduling
    @form = ReschedulingForm.new(category: params[:category])
  end
end
