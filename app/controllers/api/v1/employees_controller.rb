module Api
  module V1
    class EmployeesController < ApplicationController
      def index
        employees = Employee.includes(:department)

        employees = employees.where(department_id: params[:department_id]) if params[:department_id]

        render json: employees.as_json(include: :department)
      end
    end
  end
end
