# coding: utf-8
module LectureTimeline::CellDecorator
  BEGINNING_OF_DAY = Settings.timetable.beginning_of_day
  END_OF_DAY = Settings.timetable.end_of_day
  TIME_FORMAT = '%H:%M'

  def styles(i)
    "left:#{left}%;top:#{top * i}%;width:#{width}%;height:#{height}%;"
  end

  def top
    1 / lectures.size.to_f * 100
  end

  def left
    (time_to_f(period.start_time) - beginning_of_day) / day * 100
  end

  def width
    (Time.parse(period.end_time) - Time.parse(period.start_time)) / day * 100
  end

  def height
    1 / lectures.size.to_f * 100
  end

  def start_time
    Time.parse(period.start_time).strftime(TIME_FORMAT)
  end

  def end_time
    Time.parse(period.end_time).strftime(TIME_FORMAT)
  end

  private

  def day
    end_of_day - beginning_of_day
  end

  def beginning_of_day
    time_to_f(BEGINNING_OF_DAY)
  end

  def end_of_day
    time_to_f(END_OF_DAY)
  end

  def time_to_f(time_str)
    time = Time.parse(time_str)
    time - time.beginning_of_day
  end
end
