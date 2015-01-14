class LectureMapper
  include SAXMachine

  element 'Name', as: :name
  element 'Grade', as: :grade, class: Integer
  element 'Department', as: :department
  element 'Course', as: :course
  element 'SpecialTarget', as: :special_target, &:underscore
  element 'Code', as: :code, class: String
  elements 'Period', as: :periods, class: PeriodMapper
  elements 'Lecturer', as: :lecturers

  def self.parse(xml)
    doc = Nokogiri::XML(xml.gsub(/[\t\n\r]/, ''))
    doc.xpath('//xmlns:Lecture').map { |lecture_xml| super(lecture_xml.to_s) }
  end

  def to_record
    Lecture.new(name: @name, special_target: @special_target, code: @code)
  end

  def department_params
    { name: @department }
  end

  def course_params
    { name: @course }
  end

  def lecturer_params
    @lecturers.map { |name| { name: name } }
  end

  def period_params
    @periods.map(&:to_h)
  end
end
