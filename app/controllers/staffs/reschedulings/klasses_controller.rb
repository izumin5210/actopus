class Staffs::Reschedulings::KlassesController < Staffs::KlassesController
  before_action :set_rescheduling, only: %i(timetable)

  def set_rescheduling
    @rescheduling = Rescheduling.new
  end
end
