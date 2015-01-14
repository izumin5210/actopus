module XMLHelper
  def timetable_xml(content = [])
    <<-EOS
<TimeTable_xml xmlns="http://www.akashi.ac.jp/timetable" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.akashi.ac.jp/xmlns/timetable timetable.xsd">
  <TimeTable>
    <Common>
      <Institution>Akashi National College of Technology</Institution>
      <AcademicYear>2014</AcademicYear>
      <AcademicTerm>後期</AcademicTerm>
    </Common>
    <Lectures>
    #{content.join("\n")}
    </Lectures>
  </TimeTable>
</TimeTable_xml>
    EOS
  end

  def lecture_xml(
    name: 'プログラミング I', grade: 1, special_target: nil,
    department: '電気情報工学科', course: nil,
    lecturers: ['新井 イスマイル'],
    periods: [
      { wday: 1, start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' }
    ])
    <<-EOS
<Lecture>
  <Name>#{name}</Name>
  <Grade>#{grade}</Grade>
  <Department>#{department}</Department>
  #{"<Course>#{course}</Course>" unless course.nil?}
  #{"<SpecialTarget>#{special_target}</SpecialTarget>" unless special_target.nil?}
  <Periods>
    #{periods.map { |p| period_xml(p) }.join("\n")}
  </Periods>
  <Lectures>
    #{lecturers.map { |l| "<Lecturer>#{l}</Lecturer>" }.join("\n")}
  </Lectures>
</Lecture>
    EOS
  end

  private

  def period_xml(
    wday: 1, start_time: '09:00:00+09:00', end_time: '10:30:00+09:00')
    <<-EOS
    <Period>
      <Wday>#{wday}</Wday>
      <StartTime>#{start_time}</StartTime>
      <EndTime>#{end_time}</EndTime>
    </Period>
    EOS
  end
end
