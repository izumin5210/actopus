class Hour
  include Comparable

  attr_reader :hour, :min, :sec, :zone

  def initialize(time_str)
    time = Time.zone.parse(time_str)
    @hour = time.hour
    @min = time.min
    @sec = time.sec
    @zone = time.strftime('%:z')
  end

  def <=>(other)
    to_time <=> other.to_time
  end

  def to_time
    Time.zone.parse(to_s)
  end

  def to_s
    "#{'%02d' % @hour}:#{'%02d' % @min}:#{'%02d' % @sec}#{@zone}"
  end
end
