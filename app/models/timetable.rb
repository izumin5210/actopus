class Timetable
  attr_reader :rows
  def initialize(lectures)
    @rows = {}
    lectures.each do |lecture|
      lecture.wday_periods.each do |wday_period|
        wday = wday_period.wday
        @rows[wday] ||= Row.new
        @rows[wday] << Cell.new(lecture: lecture, period: wday_period.period)
      end
    end
  end

  class Row
    attr_reader :cells
    def initialize
      @cells = []
    end

    def <<(cell)
      @cells << cell
    end
  end

  class Cell
    include ActiveModel::Model
    attr_accessor :lecture, :period
  end
end
