# coding: utf-8
require 'rails_helper'

describe LectureTimeline::CellDecorator do
  let(:cell) do
    LectureTimeline::Cell.new(period).tap do |c|
      c.extend LectureTimeline::CellDecorator
      allow(c).to receive_message_chain(:lectures, :size).and_return(1)
    end
  end
  subject { cell }
  it { should be_a LectureTimeline::Cell }

  let(:period) { build(:period) }

  describe '#top' do
    subject { cell.top }
    it { is_expected.to be_between(0, 100) }
  end

  describe '#left' do
    subject { cell.left }
    it { is_expected.to be_between(0, 100) }
  end

  describe '#width' do
    subject { cell.width }
    it { is_expected.to be_between(0, 100) }
  end

  describe '#height' do
    subject { cell.height }
    it { is_expected.to be_between(0, 100) }
  end
end
