module TimetableDisplayable
  extend ActiveSupport::Concern

  included do
    before_action :set_date, only: %i(timetable)
    before_action :set_date_step, only: %i(timetable)
    before_action :set_lectures, only: %i(timetable)
  end

  def timetable
    @timeline = LectureTimeline.new(@lectures)
  end

  private

  def set_date_step
    @date_step = @date.beginning_of_week.step(@date.end_of_week)
  end

  def set_date
    @date = Date.parse(params[:date])
  rescue
    @date = Date.current
  end
end
