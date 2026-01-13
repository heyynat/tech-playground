require 'rails_helper'

RSpec.describe 'API V1 - Employees', type: :request do
  describe 'GET /api/v1/employees' do
    context 'when there are employees' do
      before do
        create_list(:employee, 3)
      end

      it 'returns all employees' do
        get '/api/v1/employees'

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)

        expect(body).to be_an(Array)
        expect(body.size).to eq(3)
      end
    end

    context 'when filtering by department' do
      let(:department) { create(:department, name: 'Technology') }

      before do
        create(:employee, department: department)
        create(:employee)
      end

      it 'returns only employees from the given department' do
        get '/api/v1/employees', params: { department_id: department.id }

        body = JSON.parse(response.body)

        expect(body.size).to eq(1)
        expect(body.first['department']['name']).to eq('Technology')
      end
    end
  end
end
