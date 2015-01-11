class LectureTimeline
  include Enumerable

  def initialize(lectures)
    @rows = {}
    lectures.each do |lecture|
      lecture.wday_periods.each do |wday_period|
        wday, period = wday_period.wday, wday_period.period
        @rows[wday] ||= Row.new
        cell = @rows[wday].find_or_initialize_by_period(period)
        cell << lecture
      end
    end
  end

  def each(&block)
    if block_given?
      @rows.sort.each(&block)
    else
      @rows.to_enum(:each)
    end
  end

  def each_wday(wday, &block)
    target = @rows[wday]
    block_given? ? target.each(&block) : target.to_enum(:each)
  end

  def wdays
    @rows.keys.sort
  end

  def self.parse(grouped_lectures)
    Hash[grouped_lectures.map { |k, l| [k, LectureTimeline.new(l)] }]
  end

  class Row
    attr_reader :cells

    def initialize
      @cells = []
    end

    def <<(cell)
      @cells << cell
    end

    def find_or_initialize_by_period(period)
      @cells.find { |c| c.period == period } ||
        Cell.new(period).tap { |cell| @cells << cell }
    end

    def each(&block)
      block_given? ? @cells.each(&block) : @cells.to_enum(:each)
    end
  end

  class Cell
    attr_reader :period, :lectures
    include Enumerable

    def initialize(period)
      @period = period
      @lectures = []
    end

    def <<(lecture)
      @lectures << lecture
    end
  end
end
