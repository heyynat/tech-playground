require 'rails_helper'

RSpec.describe 'API V1 - Metrics', type: :request do
  describe 'GET /api/v1/metrics/enps' do
    subject(:make_request) { get '/api/v1/metrics/enps' }

    context 'when there are no responses' do
      it 'returns zero score and count' do
        make_request

        expect(response).to have_http_status(:ok)
        
        body = JSON.parse(response.body)
        expect(body).to include('enps', 'total_responses')
        expect(body['enps']).to eq(0)
        expect(body['total_responses']).to eq(0)
      end
    end

    context 'when there are responses' do
      before do
        # 1 Promoter (9-10)
        create(:survey_response, enps: 10)
        # 1 Detractor (0-6)
        create(:survey_response, enps: 2)
        # 1 Passive (7-8)
        create(:survey_response, enps: 8)
      end

      it 'returns valid eNPS score between -100 and 100' do
        make_request

        body = JSON.parse(response.body)
        expect(body['enps']).to be_between(-100, 100)
      end

      it 'includes total responses count' do
        make_request

        body = JSON.parse(response.body)
        expect(body['total_responses']).to eq(3)
      end

      it 'calculates eNPS correctly for balanced responses' do
        make_request

        # Total = 3, Promoters = 1 (33%), Detractors = 1 (33%)
        # Score = 0
        body = JSON.parse(response.body)
        expect(body['enps']).to eq(0)
      end
    end

    context 'with mostly promoters' do
      before do
        create_list(:survey_response, 6, enps: 10)  # 60% Promoters
        create_list(:survey_response, 2, enps: 8)   # 20% Passives
        create_list(:survey_response, 2, enps: 4)   # 20% Detractors
      end

      it 'returns positive score' do
        make_request

        body = JSON.parse(response.body)
        expect(body['enps']).to eq(40)
      end
    end
  end
end

