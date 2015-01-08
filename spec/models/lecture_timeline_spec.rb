require 'rails_helper'

describe LectureTimeline do
  let(:wday_periods) do
    [1, 2].map { |wday| create_list(:wday_period, 2, wday: wday) }.flatten
  end
  let(:term) { create(:term) }
  let(:lectures) do
    wday_periods.map do |wday_period|
      lecture = create(:lecture, :with_klass, term: term)
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
      Hash[[1, 2].map { |i| [i, [build(:lecture, :with_klass, term: term)]] }]
    end

    subject { LectureTimeline.parse(grouped_lectures) }
    it { expect(subject.size).to eq 2 }
    it { expect(subject.keys).to match_array([1, 2]) }
  end
end
