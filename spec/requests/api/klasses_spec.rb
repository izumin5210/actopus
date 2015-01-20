require 'rails_helper'

RSpec.describe 'classes resource', type: :request do
  let(:classes_structure) do
    { 'id' => a_kind_of(String),
      'name' => a_kind_of(String),
      'grade' => a_kind_of(Integer),
      'department' => a_kind_of(String),
      'course' => a_kind_of(String)
    }
  end

  let!(:klass) { create(:klass, :with_department, :with_course) }

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
end
