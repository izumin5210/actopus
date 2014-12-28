class LectureMapper
  include SAXMachine

  element 'Name', as: :name
  element 'Grade', as: :grade, class: Integer
  element 'Department', as: :department
  element 'Course', as: :course
  elements 'Lecturer', as: :lecturers
  element 'Wday', as: :wday, class: Integer
  element 'StartTime', as: :begin_at
  element 'EndTime', as: :end_at

  def self.parse(xml)
    doc = Nokogiri::XML(xml.gsub(/[\t\n\r]/, ''))
    doc.xpath('//xmlns:Lecture').map do |lecture|
      super(lecture.to_s)
    end
  end
end
