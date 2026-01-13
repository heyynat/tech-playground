require 'rails_helper'

RSpec.describe 'API V1 - Employees', type: :request do
  describe 'GET /api/v1/employees' do
    context 'when there are employees' do
      before { create_list(:employee, 3) }

      it 'returns success' do
        get '/api/v1/employees'
        expect(response).to have_http_status(:ok)
      end

      it 'returns all employees with correct structure' do
        get '/api/v1/employees'

        body = JSON.parse(response.body)
        expect(body).to be_an(Array)
        expect(body.size).to eq(3)
        
        # Test API contract
        first_employee = body.first
        expect(first_employee).to include('id', 'name', 'corporate_email', 'department')
        expect(first_employee['department']).to include('id', 'name')
      end
    end

    context 'when filtering by department' do
      let(:department) { create(:department, name: 'Technology') }

      before do
        create_list(:employee, 2, department: department)
        create(:employee)  # Different department
      end

      it 'returns only employees from specified department' do
        get '/api/v1/employees', params: { department_id: department.id }

        body = JSON.parse(response.body)
        expect(body.size).to eq(2)
        
        body.each do |employee|
          expect(employee['department']['id']).to eq(department.id)
        end
      end
    end
  end
end

