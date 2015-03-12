module ReschedulingsCreatable
  extend ActiveSupport::Concern

  included do
    before_action :set_rescheduling, only: %i(timetable)
    before_action :set_periods, only: %i(timetable)
  end

  private

  def set_rescheduling
    @rescheduling = Rescheduling.new
  end

  def set_periods
    @periods = Period.all
  end
end
