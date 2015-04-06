require 'rails_helper'

RSpec.describe 'lecture resources', type: :request do
  let(:lecture_structure) do
    { 'name' => a_kind_of(String),
      'grade' => a_kind_of(Integer),
      'department' => a_kind_of(String),
      'course' => a_kind_of(String),
      'lecturers' => a_kind_of(Array),
      'periods' => a_kind_of(Array),
      'special_target' => a_kind_of(String),
      'code' => a_kind_of(String)
    }
  end

  create_term_and_freeze_time

  let(:klass) { create(:klass, :with_course) }
  let!(:lecture) do
    create(:lecture,
           lecturers_count: 3,
           wday_periods_count: 3,
           special_target: 'female',
           klass: klass,
           term: term)
  end

  describe 'GET /api/v1/lectures' do
    it 'returns lecture resources' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match([lecture_structure])
    end
  end

  describe 'GET /api/v1/lectures/:id' do
    let(:id) { lecture.id }
    it 'returns lecture resource' do
      is_expected.to eq 200
      expect(JSON.parse(response.body)).to match(lecture_structure)
    end
  end
end
