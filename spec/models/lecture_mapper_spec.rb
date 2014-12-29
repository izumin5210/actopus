require 'rails_helper'

describe LectureMapper do

  let(:xml) { timetable_xml(lectures_xml) }

  describe '.parse' do
    let(:mappers) { LectureMapper.parse(xml) }
    let(:mapper) { mappers.first }
    context 'without course' do
      let(:lectures_xml) { [lecture_xml] }
      let(:period) { mapper.periods.first }
      it { expect(mapper.name).to eq 'プログラミング I' }
      it { expect(mapper.grade).to eq 1 }
      it { expect(mapper.department).to eq '電気情報工学科' }
      it { expect(mapper.lecturers).to match_array('新井 イスマイル') }
      it { expect(period.start_time).to eq Hour.new('09:00:00+09:00') }
      it { expect(period.end_time).to eq Hour.new('10:30:00+09:00') }
    end

    context 'with course' do
      let(:lectures_xml) { [lecture_xml(course: '情報工学コース')] }
      it { expect(mapper.course).to eq '情報工学コース' }
    end

    context 'with 5 lectures' do
      let(:lectures_xml) { [lecture_xml] * 5 }
      it { expect(mappers.size).to eq 5 }
    end

    context 'with 2 periods' do
      let(:lectures_xml) do
        period_params = [
          { start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' },
          { start_time: '10:40:00+09:00', end_time: '12:10:00+09:00' }
        ]
        [lecture_xml(periods: period_params)]
      end
      let(:periods) { mapper.periods }
      it { expect(periods.size).to eq 2 }
      it { expect(periods[0].start_time).to eq Hour.new('09:00:00+09:00') }
      it { expect(periods[0].end_time).to eq Hour.new('10:30:00+09:00') }
      it { expect(periods[1].start_time).to eq Hour.new('10:40:00+09:00') }
      it { expect(periods[1].end_time).to eq Hour.new('12:10:00+09:00') }
    end
  end
end
