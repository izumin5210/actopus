# coding: utf-8
module Timetable::CellDecorator
  def styles
    "left:#{left}%;top:#{top}%;width:#{width}%;height:#{height}%;"
  end

  def top
    layer_index / layer_count.to_f * 100
  end

  def left
    range.begin / day * 100
  end

  def width
    (range.end - range.begin) / day * 100
  end

  def height
    1 / layer_count.to_f * 100
  end

  private

  def day
    (end_of_day - beginning_of_day).to_f
  end

  def beginning_of_day
    time_to_i(Timetable::BEGINNING_OF_DAY)
  end

  def end_of_day
    time_to_i(Timetable::END_OF_DAY)
  end
end
