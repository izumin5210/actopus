require 'rails_helper'

RSpec.describe 'classes resource', type: :request do
  create_term_and_freeze_time

  let(:classes_structure) do
    { 'id' => a_kind_of(String),
      'name' => a_kind_of(String),
      'grade' => a_kind_of(Integer),
      'department' => a_kind_of(String),
      'course' => a_kind_of(String)
    }
  end

  let(:timetable_structure) do
    { 'cells' => [cell_structure],
      'beginning_of_week' => /\d{4}-\d{2}-\d{2}/,
      'end_of_week' => /\d{4}-\d{2}-\d{2}/
    }
  end

  let(:cell_structure) do
    { 'category' => /normal|addition|cancel/,
      'scheduled_on' => /\d{4}-\d{2}-\d{2}/,
      'period_time' => a_kind_of(Hash),
      'lecture' => a_kind_of(Hash),
      'rescheduling' => a_kind_of(Hash).or(be_blank)
    }
  end

  let!(:klass) { create(:klass, :with_course) }

  describe 'GET /api/v1/classes' do
    it 'returns class resources' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match([classes_structure])
    end
  end

  describe 'GET /api/v1/classes/:id' do
    let(:id) { klass.slug }
    it 'returns class resource' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match(classes_structure)
    end
  end

  describe 'GET /api/v1/classes/:id/timetable' do
    let(:id) { klass.slug }
    before do
      create(:lecture,
             periods_count: 1, lecturers_count: 1,
             term: term, klass: klass)
    end
    it 'returns class resource' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match(timetable_structure)
    end
  end
end
