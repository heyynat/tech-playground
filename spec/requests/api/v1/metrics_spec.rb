require 'rails_helper'

RSpec.describe 'API V1 - Metrics', type: :request do
  describe 'GET /api/v1/metrics/enps' do
    context 'when there are no responses' do
      it 'returns enps as 0' do
        get '/api/v1/metrics/enps'

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['enps']).to eq(0)
      end
    end

    context 'when there are responses' do
      before do
        # 1 Promoter (9-10)
        create(:survey_response, enps: 10)
        # 1 Detractor (0-6)
        create(:survey_response, enps: 2)
        # 1 Passive (7-8) - omitted from calculation usually, but total count matters
        create(:survey_response, enps: 8)
      end

      # eNPS = % Promoters - % Detractors
      # Total = 3
      # Promoters = 1 (33.3%)
      # Detractors = 1 (33.3%)
      # Score = 0
      it 'calculates eNPS correctly' do
        get '/api/v1/metrics/enps'

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['enps']).to eq(0)
      end

      it 'calculates a positive eNPS' do
          # Add more promoters
          create_list(:survey_response, 2, enps: 10)

          # Total = 5
          # Promoters = 3 (60%)
          # Detractors = 1 (20%)
          # Score = 40

          get '/api/v1/metrics/enps'
          expect(JSON.parse(response.body)['enps']).to eq(40)
      end
    end
  end
end
