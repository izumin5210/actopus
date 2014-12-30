class PeriodMapper
  include SAXMachine

  element 'StartTime', as: :start_time
  element 'EndTime', as: :end_time

  def to_h
    { start_time: @start_time, end_time: @end_time }
  end
end
