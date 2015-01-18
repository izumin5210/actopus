class Timetable
  BEGINNING_OF_DAY = Settings.timetable.beginning_of_day
  END_OF_DAY = Settings.timetable.end_of_day

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
    @rows.each { |wday, row| row.layered! }
  end

  class Row
    attr_reader :cells
    def initialize
      @cells = []
    end

    def <<(cell)
      @cells << cell
    end

    def layered!
      @cells.each.with_index do |cell, i|
        @cells.each.with_index do |other_cell, j|
          next if i == j
          if cell.range.overlaps?(other_cell.range)
            cell.layer_count += 1
            if cell.layer_index < other_cell.layer_index
              cell.layer_index = other_cell.layer_index + 1
            end
          end
        end
        cell.layer_index = 0 if cell.layer_index == -1
      end
    end
  end

  class Cell
    include ActiveModel::Model
    attr_accessor :lecture, :period, :range, :layer_count, :layer_index
    delegate :start_time, :end_time, to: :period
    def initialize(*args)
      super(*args)
      base = time_to_i(BEGINNING_OF_DAY)
      @range = (time_to_i(start_time) - base)..(time_to_i(end_time) - base)
      @layer_count = 1
      @layer_index = -1
    end

    def time_to_i(time_str)
      Time.parse(time_str).to_i
    end
  end
end
