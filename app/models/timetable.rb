class Timetable
  include ActiveModel::Model
  attr_accessor :cells

  class Cell
    include ActiveModel::Model
    attr_accessor :lecture, :category, :scheduled_on, :period_time, :rescheduling
  end

  def self.create_from_klass(klass, all_week = Date.today.all_week)
    lectures = klass.lectures.current_term.includes(:periods)
    create_from_lectures(lectures, all_week)
  end

  def self.create_from_lecturer(lecturer, all_week = Date.today.all_week)
    lectures = lecturer.lectures.current_term.includes(:periods)
    create_from_lectures(lectures, all_week)
  end

  private

  def self.create_from_lectures(lectures, all_week)
    cells = all_week.inject([]) do |cells, date|
        cells + create_cells_from_lectures_by_date(lectures, date)
      end
    Timetable.new(cells: cells)
  end

  def self.create_cells_from_lectures_by_date(lectures, date)
    lectures.where(periods: { wday: date.wday }).map { |lecture|
      create_cells_from_lecture_by_date(lecture, date)
    }.flatten
  end

  def self.create_cells_from_lecture_by_date(lecture, date)
    periods = lecture.periods.select { |period| period.wday == date.wday }
    periods.map do |period|
      Timetable::Cell.new(
        lecture: lecture,
        category: :normal,
        scheduled_on: date,
        period_time: period.period_time
      )
    end
  end
end
