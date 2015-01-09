require 'rails_helper'

describe LectureMapper do

  let(:xml) { timetable_xml(lectures_xml) }
  let(:mapper) { LectureMapper.new(mapper_params) }

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
      it { expect(period.start_time).to eq '09:00:00+09:00' }
      it { expect(period.end_time).to eq '10:30:00+09:00' }
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
      it { expect(periods[0].start_time).to eq '09:00:00+09:00' }
      it { expect(periods[0].end_time).to eq '10:30:00+09:00' }
      it { expect(periods[1].start_time).to eq '10:40:00+09:00' }
      it { expect(periods[1].end_time).to eq '12:10:00+09:00' }
    end
  end

  describe '#to_record' do
    let(:mapper_params) { { name: 'プログラミング I' } }
    subject { mapper.to_record }
    it { expect(subject.name).to eq 'プログラミング I' }
  end

  describe '#department_params' do
    let(:mapper_params) { { department: department_name } }
    let(:department_name) { '電気情報工学科' }
    subject { mapper.department_params }
    it { is_expected.to match(name: department_name) }
  end

  describe '#course_params' do
    let(:mapper_params) { { course: course_name } }
    let(:course_name) { '情報工学コース' }
    subject { mapper.course_params }
    it { is_expected.to match(name: course_name) }
  end

  describe '#lecturer_params' do
    let(:mapper_params) { { lecturers: lecturer_names } }
    let(:lecturer_names) { ['新井 イスマイル', '佐村 敏治'] }
    subject { mapper.lecturer_params }
    it { is_expected.to match(lecturer_names.map { |n| { name: n } }) }
  end

  describe '#period_params' do
    let(:mapper_params) { { periods: periods } }
    let(:periods) do
      [
        { start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' },
        { start_time: '10:40:00+09:00', end_time: '12:10:00+09:00' }
      ]
    end
    subject { mapper.period_params }
    it { expect(subject[0]).to match(periods[0]) }
    it { expect(subject[1]).to match(periods[1]) }
  end
end
