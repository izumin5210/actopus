module ReschedulingsCreatable
  extend ActiveSupport::Concern

  included do
    before_action :set_rescheduling, only: %i(timetable)
    before_action :set_periods, only: %i(timetable)
  end

  private

  def set_rescheduling
    @form = ReschedulingForm.new(
      category: params[:category], lecture_id: params[:lecture_id],
      before_period_id: params[:before_period_id],
      before_date: params[:before_date])
  end

  def set_periods
    @periods = Period.all
  end
end
