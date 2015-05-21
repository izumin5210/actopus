require 'rails_helper'

RSpec.describe 'reschedulings resource', type: :request do
  include OAuthHelper
  create_term_and_freeze_time

  let(:rescheduling_structure) do
    { 'category' => /extra|cancel|change/,
      'lecture' => a_kind_of(Hash)
    }
  end

  let(:lecture) { create(:lecture, periods_count: 1, term: term) }
  let(:resource_owner) { create(:staff) }

  describe 'POST /api/internal/reschedulings' do
    let(:params) do
      { lecture_id: lecture.id,
        period_time_id: lecture.periods.first.period_time,
        scheduled_on: now.next_week.to_date,
        category: 'cancel'
      }
    end

    it 'returns 403 forbidden' do
      is_expected.to eq 403
    end

    context 'with write_rescheduling scope' do
      let(:scopes) { 'public write_rescheduling' }
      it 'returns rescheduling resource' do
        is_expected.to eq 201
        expect(JSON.parse(response.body)).to match(rescheduling_structure)
      end
    end
  end

  describe 'DELETE /api/internal/reschedulings/:id' do
    let(:id) { rescheduling.id }
    let(:rescheduling) do
      create(:rescheduling, lecture: lecture, category: 'cancel')
    end

    it 'returns 403 forbidden' do
      is_expected.to eq 403
    end

    context 'with write_rescheduling scope' do
      let(:scopes) { 'public write_rescheduling' }
      it 'returns rescheduling resource' do
        is_expected.to eq 204
        expect(response.body).to be_blank
      end
    end
  end
end
