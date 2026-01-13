class EmployeeSerializer
  def initialize(employee)
    @employee = employee
  end

  def as_json
    {
      id: @employee.id,
      name: @employee.name,
      corporate_email: @employee.corporate_email,
      position: @employee.position,
      role: @employee.role,
      location: @employee.location,
      gender: @employee.gender,
      generation: @employee.generation,
      company_tenure: @employee.company_tenure,
      department: {
        id: @employee.department.id,
        name: @employee.department.name
      }
    }
  end
end
