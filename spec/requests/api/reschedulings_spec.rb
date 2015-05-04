require 'rails_helper'

RSpec.describe 'rescheduling resources', type: :request do
  create_term_and_freeze_time

  let(:rescheduling_structure) do
    { 'category' => /extra|cancel|change/,
      'lecture' => a_kind_of(Hash)
    }
  end

  let(:lecture) do
    create(:lecture,
           lecturers_count: 3,
           periods_count: 3,
           term: term,
           special_target: 'female')
  end
  let!(:rescheduling) do
    create(:rescheduling,
           category: 'cancel', lecture: lecture,
           scheduled_on: now)
  end

  describe 'GET /api/v1/reschedulings' do
    it 'returns rescheduling resources' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match([rescheduling_structure])
    end
  end
end
