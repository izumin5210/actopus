require 'rails_helper'

describe LectureTimeline do
  let(:periods) do
    [
      create(:period,
        name: '1', start_time: '09:00:00+09:00', end_time: '10:30:00+09:00'),
      create(:period,
        name: '2', start_time: '10:40:00+09:00', end_time: '12:10:00+09:00')
    ]
  end
  let(:wday_periods) do
    periods.map { |period|
      (1..2).map { |wday| period.wday_periods.create(wday: wday) }
    }.flatten
  end
  let(:departments) { [create(:department, :e), create(:department, :m)] }
  let(:term) { create(:term) }
  let(:lectures) do
    wday_periods.map.with_index do |wday_period, i|
      lecture = create(:lecture,
                       name: "Lecture #{i}",
                       department: departments[0],
                       term: term
                      )
      lecture.tap { |l| wday_period.lectures << l }
    end
  end
  let(:lecture_timeline) { LectureTimeline.new(lectures) }

  it { expect(LectureTimeline.ancestors).to include(Enumerable) }

  describe '#wdays' do
    subject { lecture_timeline.wdays }
    it { is_expected.to match_array([1, 2]) }
    it { expect(subject.size).to eq 2 }
  end

  describe '#each' do
    context 'without block' do
      subject { lecture_timeline.each }
      it { is_expected.to be_kind_of Enumerator }
    end

    context 'with block' do
      it do
        expect { |b| lecture_timeline.each(&b) }.to yield_control.exactly(2)
      end
      it do
        expect { |b| lecture_timeline.each(&b) }.to yield_successive_args(
          [Integer, LectureTimeline::Row], [Integer, LectureTimeline::Row]
        )
      end
    end
  end

  describe '#each_wday' do
    context 'without block' do
      subject { lecture_timeline.each_wday(1) }
      it { is_expected.to be_kind_of Enumerator }
    end

    context 'with block' do
      it do
        expect { |b|
          lecture_timeline.each_wday(1, &b)
        }.to yield_control.exactly(2)
      end
      it do
        expect { |b|
          lecture_timeline.each_wday(1, &b)
        }.to yield_successive_args(LectureTimeline::Cell, LectureTimeline::Cell)
      end
    end
  end

  describe '.parse' do
    let(:grouped_lectures) do
      Hash[departments.map { |d|
        [d, [build(:lecture, department: d, term: term)]]
      }]
    end

    subject { LectureTimeline.parse(grouped_lectures) }
    it { expect(subject.size).to eq 2 }
    it { expect(subject.keys).to match_array(departments) }
  end
end
