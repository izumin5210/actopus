# coding: utf-8
module PeriodTimeDecorator
  def to_display
    time_str = [start_time, end_time].map { |t|
        Time.parse(t).strftime('%H:%M')
      }.join(' ~ ')
    "#{name} #{time_str}"
  end
end
