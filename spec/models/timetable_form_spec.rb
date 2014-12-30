require 'rails_helper'

describe TimetableForm do
  let(:timetable_form) do
    TimetableForm.new(
      name: '後期', timetable_xml: xml,
      start_on: Date.new(2014, 10, 1), end_on: Date.new(2015, 2, 28))
  end

  let(:xml) do
    double('timetable').tap do |d|
      allow(d).to receive_message_chain(:tempfile, :read).and_return(timetable_xml(lecture_xmls))
      allow(d).to receive(:original_filename).and_return('timetable201410.xml')
    end
  end

  let(:lecture_xmls) do
    [
      lecture_xml,
      lecture_xml(
        name: '機械工学実習 II', grade: 2, department: '機械工学科', wday: 2,
        lecturers: ['加藤 隆弘', '関森 大介', '岩野 優樹', '大森 茂俊'],
        periods: [
          { start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' },
          { start_time: '10:40:00+09:00', end_time: '12:10:00+09:00' }
        ]
      )
    ]
  end

  before do
    %w(department course period).each do |seed|
      load Rails.root.join("db/seeds/#{seed}.rb")
    end
  end

  subject { timetable_form }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_on) }
    it { is_expected.to validate_presence_of(:end_on) }
    it { is_expected.to validate_presence_of(:timetable_xml) }
  end

  describe '#save' do
    subject { timetable_form.save }
    context 'with valid xml' do
      it { is_expected.to be true }
      it { expect { subject }.to change(Term, :count).by(1) }
      it { expect { subject }.to change(Lecture, :count).by(2) }
      it { expect { subject }.to change(Lecturer, :count).by(5) }
      it do
        department = Department.find_by(name: '電気情報工学科')
        expect { subject }.to change(department.lectures, :count).by(1)
      end
      it do
        period = Period.find_by(start_time: '09:00:00+09:00', end_time: '10:30:00+09:00')
        expect { subject }.to change(period.lectures, :count).by(2)
      end
      it { expect(timetable_form.tap(&:save).term.lectures.size).to eq 2 }
      it do
        expect(timetable_form.tap(&:save).count).to match(lecture: 2, lecturer: 5)
      end
    end

    context 'with invalid xml' do
      let(:lecture_xmls) do
        [
          lecture_xml,
          lecture_xml(
            name: '機械工学実習 II', grade: nil, department: '機械工学科', wday: 2,
            lecturers: ['加藤 隆弘', '関森 大介', '岩野 優樹', '大森 茂俊'],
            periods: [
              { start_time: '09:00:00+09:00', end_time: '10:30:00+09:00' },
              { start_time: '10:40:00+09:00', end_time: '12:10:00+09:00' }
            ]
          )
        ]
      end
      it { is_expected.to be false }
      it { expect { subject }.to_not change(Term, :count) }
      it { expect { subject }.to_not change(Lecture, :count) }
      it { expect { subject }.to_not change(Lecturer, :count) }
    end
  end
end
