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
      departments = Department.all
      courses = Course.all
      periods = Period.all
      lecturers = Lecturer.all
      Lecture.transaction do
        LectureMapper.parse(@timetable_xml.tempfile.read).each do |mapper|
          lecture = mapper.to_record
          lecture.department = departments.find { |d| d.name == mapper.department }
          lecture.course = courses.find { |d| d.name == mapper.course }
          lecture.term = term
          lecture.save!
          mapper.period_params.each do |params|
            period = periods.find do |p|
                (p.start_time == params[:start_time]) && (p.end_time == params[:end_time])
              end
            lecture.held_lectures.create!(period: period, wday: mapper.wday)
          end
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
    end
  end
end
