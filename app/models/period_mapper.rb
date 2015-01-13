class PeriodMapper
  include SAXMachine

  element 'Wday', as: :wday, class: Integer
  element 'StartTime', as: :start_time
  element 'EndTime', as: :end_time

  def to_h
    { wday: @wday, start_time: @start_time, end_time: @end_time }
  end
end
