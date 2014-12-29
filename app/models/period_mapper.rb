class PeriodMapper
  include SAXMachine

  element 'StartTime', as: :start_time do |start_time|
    Hour.new(start_time)
  end

  element 'EndTime', as: :end_time do |end_time|
    Hour.new(end_time)
  end
end
