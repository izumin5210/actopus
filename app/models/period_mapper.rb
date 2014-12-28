class PeriodMapper
  include SAXMachine

  element 'StartTime', as: :begin_at do |begin_at|
    Hour.new(begin_at)
  end

  element 'EndTime', as: :end_at do |end_at|
    Hour.new(end_at)
  end
end
