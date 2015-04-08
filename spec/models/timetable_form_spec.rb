require 'rails_helper'

describe TimetableForm do
  let(:timetable_form) do
    TimetableForm.new(
      name: '後期', timetable_xml: xml,
      started_on: Date.new(2014, 10, 1), ended_on: Date.new(2015, 2, 28))
  end

  let(:xml) do
    double('timetable').tap do |d|
      allow(d).to receive(:read).and_return(timetable_xml(lecture_xmls))
      allow(d).to receive(:original_filename).and_return('timetable201410.xml')
    end
  end

  let(:klasses) { create_list(:klass, 2) }
  let(:period_times) { create_list(:period_time, 3) }
  let(:lecture_names) { (1..2).map { attributes_for(:lecture)[:name] } }
  let(:lecturer_names) { (1..4).map { attributes_for(:lecturer)[:name] } }

  let(:lecture_xmls) do
    klasses.map.with_index do |klass, i|
      lecture_xml(
        name: lecture_names[i], grade: klass.grade,
        department: klass.department.name,
        lecturers: lecturer_names[i * 2, 2],
        periods: period_times[i, 2].map do |p|
            { wday: i, start_time: p.start_time, end_time: p.end_time }
          end
      )
    end
  end

  subject { timetable_form }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:started_on) }
    it { is_expected.to validate_presence_of(:ended_on) }
    it { is_expected.to validate_presence_of(:timetable_xml) }
  end

  describe '#save' do
    subject { timetable_form.save }
    context 'with valid xml' do
      it { is_expected.to be true }
      it { expect { subject }.to change(AcademicTerm, :count).by(1) }
      it { expect { subject }.to change(Lecture, :count).by(2) }
      it { expect { subject }.to change(Lecturer, :count).by(4) }
      it { expect { subject }.to change(Period, :count).by(4) }
      it { expect(timetable_form.tap(&:save).term.lectures.size).to eq 2 }
      it { expect { subject }.to change(klasses[0].lectures, :count).by(1) }
      it do
        subject
        lecture = Lecture.find_by(name: lecture_names[0])
        expect(lecture.periods.size).to eq 2
      end
      it do
        expect(timetable_form.tap(&:save).count).to match(lecture: 2, lecturer: 4)
      end
    end

    context 'with invalid xml' do
      let(:lecture_xmls) { [lecture_xml(grade: nil)] }
      it { is_expected.to be false }
      it { expect { subject }.to_not change(AcademicTerm, :count) }
      it { expect { subject }.to_not change(Lecture, :count) }
      it { expect { subject }.to_not change(Lecturer, :count) }
      it { expect { subject }.to_not change(Period, :count) }
    end
  end
end
