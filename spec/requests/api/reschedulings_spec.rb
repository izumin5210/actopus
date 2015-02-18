require 'rails_helper'

RSpec.describe 'rescheduling resources', type: :request do
  let(:rescheduling_structure) do
    { 'category' => /extra|cancel|change/,
      'taken_on' => /\A\d{4}-\d{2}-\d{2}\Z/,
      'lecture' => a_kind_of(Hash),
      'period' => a_kind_of(Hash)
    }
  end

  let(:period) { create(:period) }
  let(:lecture) do
    create(:lecture,
           :with_klass, :with_term,
           lecturers_count: 3, wday_periods_count: 3,
           special_target: 'female')
  end
  let(:taken_on) { Date.tomorrow }
  let!(:rescheduling) do
    create(:rescheduling,
           category: 'cancel', taken_on: taken_on,
           lecture: lecture, period: period)
  end
  before { Timecop.freeze(taken_on - 10.days) }
  after { Timecop.return }

  describe 'GET /api/v1/reschedulings' do
    it 'returns rescheduling resources' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match([rescheduling_structure])
    end
  end
end
