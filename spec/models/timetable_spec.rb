require 'rails_helper'

RSpec.describe Timetable, type: :model do
  let(:periods) do
    [
      create(:period, start_time: '09:00:00+09:00', end_time: '10:30:00+09:00'),
      create(:period, start_time: '10:40:00+09:00', end_time: '12:10:00+09:00'),
      create(:period, start_time: '11:25:00+09:00', end_time: '12:10:00+09:00')
    ]
  end
  let(:wday_periods) do
    (1..2).map do |wday|
      periods.map { |period| create(:wday_period, wday: wday, period: period) }
    end
  end
  let(:lectures) do
    [
      build(:lecture, wday_periods: [wday_periods[0][0]]),
      build(:lecture, wday_periods: [wday_periods[0][1]]),
      build(:lecture, wday_periods: [wday_periods[1][1]]),
      build(:lecture, wday_periods: [wday_periods[1][2]])
    ]
  end
  let(:date) { Date.new(2015, 1, 21) }
  before { Timecop.freeze(date) }
  after { Timecop.return }
  subject do
    stub_const('Timetable::BEGINNING_OF_DAY', '08:00:00+09:00')
    stub_const('Timetable::END_OF_DAY', '18:00:00+09:00')
    Timetable.new(lectures, date)
  end

  describe '#initialize' do
    it { expect(subject.rows.size).to eq 2 }
    it { expect(subject.rows[1]).to be_a Timetable::Row }
    it { expect(subject.rows[1].cells.size).to eq 2 }
    it { expect(subject.rows[1].cells[0]).to be_a Timetable::Cell }
    it { expect(subject.rows.keys).to match_array([1, 2]) }
    it { expect([*subject.rows[1].cells[0].range]).to start_with(3600) }
    it { expect([*subject.rows[1].cells[0].range]).to end_with(8999) }
    it { expect(subject.rows[1].cells[0].layer_count).to eq 1 }
    it { expect(subject.rows[2].cells[0].layer_count).to eq 2 }
    it { expect(subject.rows[2].cells[0].layer_index).to eq 0 }
    it { expect(subject.rows[2].cells[1].layer_index).to eq 1 }
  end
end
