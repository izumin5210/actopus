require 'rails_helper'

RSpec.describe Timetable, type: :model do
  create_term_and_freeze_time

  let(:all_week) { today.all_week }

  describe '.create_from_klass' do
    let!(:lectures) do
      [
        create_list(:lecture, 3, periods_count: 2, term: term, lecturers_count: 1, klass: klass),
        create_list(:lecture, 2, periods_count: 2, term: term, lecturers_count: 1)
      ].flatten
    end
    let(:klass) { create(:klass) }
    subject { Timetable.create_from_klass(klass, all_week).cells }

    context 'when the klass has no reschedulings in the week' do
      it { expect(subject.size).to eq 6 }
      it { is_expected.to all(satisfy { |c| c.lecture.klass == klass }) }
      it { is_expected.to all(satisfy { |c| all_week.cover?(c.scheduled_on) }) }
    end

    context 'when the klass has 2 reschedulings in this week' do
      pending 'Not yet implemented...'
    end
  end

  describe '.create_from_lecturer' do
    let!(:lectures) do
      [
        create_list(:lecture, 3, periods_count: 2, term: term).map { |l| l.lecturers << lecturer },
        create_list(:lecture, 2, periods_count: 2, term: term, lecturers_count: 1)
      ].flatten
    end
    let(:lecturer) { create(:lecturer) }
    subject { Timetable.create_from_lecturer(lecturer, all_week).cells }

    context 'when the lecturer has no reschedulings in the week' do
      it { expect(subject.size).to eq 6 }
      specify 'all of the cells that are included in the timetable have the lecturer' do
        is_expected.to all(satisfy { |c| c.lecture.lecturers.include?(lecturer) })
      end
      specify 'all of the cells that are included in the timetable are scheduled on this week' do
        is_expected.to all(satisfy { |c| all_week.cover?(c.scheduled_on) })
      end
    end

    context 'when the klass has 2 reschedulings in this week' do
      pending 'Not yet implemented...'
    end
  end
end
