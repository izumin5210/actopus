class TimetableForm
  include ActiveModel::Model

  attr_reader :term
  attr_accessor :name, :start_on, :end_on, :timetable_xml

  def initialize(attrs = {})
    attrs.each do |attr, value|
      public_send("#{attr}=", value) if respond_to?("#{attr}=")
    end
  end

  def save
    Term.transaction do
      @term = Term.create!(name: @name, start_on: @start_on, end_on: @end_on,
          xml_filename: @timetable_xml.original_filename)
      lecture_transaction
    end
  end

  private

  def lecture_transaction
    # TODO: 発行されるクエリ数が多すぎるのでバルクインサート等の対策を検討
    departments, courses = Department.all, Course.all
    periods, lecturers = Period.all, Lecturer.all
    Lecture.transaction do
      LectureMapper.parse(@timetable_xml.tempfile.read).each do |mapper|
        lecture = create_lecture(mapper, departments, courses)
        map_periods_onto_lecture(mapper, lecture, periods)
        map_lecturers_onto_lecture(mapper, lecture, lecturers)
      end
    end
  end

  def create_lecture(mapper, departments, courses)
    mapper.to_record.tap do |lecture|
      lecture.department = departments.find { |d| d.name == mapper.department }
      lecture.course = courses.find { |d| d.name == mapper.course }
      lecture.term = @term
      lecture.save!
    end
  end

  def map_periods_onto_lecture(mapper, lecture, periods)
    mapper.period_params.each do |params|
      period = periods.find do |p|
        (p.start_time == params[:start_time]) && (p.end_time == params[:end_time])
      end
      lecture.held_lectures.create!(period: period, wday: mapper.wday)
    end
  end

  def map_lecturers_onto_lecture(mapper, lecture, lecturers)
    mapper.lecturer_params.each do |params|
      lecturer = lecturers.find { |l| l.name == params[:name] }
      if lecturer.blank?
        lecturer = Lecturer.create!(name: params[:name])
        lecturers << lecturer
      end
      lecture.lecturers << lecturer
    end
  end
end
