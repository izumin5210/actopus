# coding: utf-8
require 'rails_helper'

describe Timetable::CellDecorator do
  let(:cell) do
    stub_const('Timetable::BEGINNING_OF_DAY', '08:00:00+09:00')
    stub_const('Timetable::END_OF_DAY', '18:00:00+09:00')
    Timetable::Cell.new(period: period).tap do |c|
      c.extend Timetable::CellDecorator
      c.layer_count = 2
      c.layer_index = 1
    end
  end
  let(:period) do
    create(:period, start_time: '09:00:00+09:00', end_time: '10:30:00+09:00')
  end
  subject { cell }
  it { should be_a Timetable::Cell }

  describe '#top' do
    subject { cell.top }
    it { is_expected.to eq 50 }
  end

  describe '#left' do
    subject { cell.left }
    it { is_expected.to eq 10 }
  end

  describe '#width' do
    subject { cell.width }
    it { is_expected.to eq 15 }
  end

  describe '#height' do
    subject { cell.height }
    it { is_expected.to eq 50 }
  end
end
