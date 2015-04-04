module TimetableDisplayable
  extend ActiveSupport::Concern

  included do
    before_action :set_date, only: %i(timetable)
    before_action :set_beginning_of_week, only: %i(timetable)
    before_action :set_end_of_week, only: %i(timetable)
    before_action :set_date_step, only: %i(timetable)
    before_action :set_lectures, only: %i(timetable)
  end

  def timetable
    @timetable = Timetable.new(@lectures, @date)
  end

  private

  def set_date
    @date = Date.parse(params[:date])
  rescue
    @date = Date.current
  end

  def set_beginning_of_week
    @beginning_of_week = @date.beginning_of_week
  end

  def set_end_of_week
    @end_of_week = @date.end_of_week
  end

  def set_date_step
    @date_step = @beginning_of_week.step(@end_of_week)
  end

  def set_lectures
    raise NotImplementedError, "#{self.class}#set_lectures is not implemented"
  end
end
