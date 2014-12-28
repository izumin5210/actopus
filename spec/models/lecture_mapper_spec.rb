require 'rails_helper'

describe LectureMapper do

  let(:xml) { timetable_xml(lectures_xml) }

  describe '.parse' do
    let(:lectures_xml) { [lecture_xml(course: '情報工学コース')] * 5 }
    let(:mappers) { LectureMapper.parse(xml) }
    let(:mapper) { mappers.first }
    it { expect(mappers.size).to eq 5 }
    it { expect(mapper.name).to eq 'プログラミング I' }
    it { expect(mapper.grade).to eq 1 }
    it { expect(mapper.department).to eq '電気情報工学科' }
    it { expect(mapper.course).to eq '情報工学コース' }
    it { expect(mapper.lecturers).to match_array('新井 イスマイル') }
    it { expect(mapper.begin_at).to eq '09:00:00+09:00' }
    it { expect(mapper.end_at).to eq '10:30:00+09:00' }
  end
end
