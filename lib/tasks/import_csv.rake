require "csv"

namespace :import do
  desc "Import survey data from CSV"
  task csv: :environment do
    CSV.foreach("public/data.csv", headers: true, col_sep: ";") do |row|
      department = Department.find_or_create_by!(name: row["area"])

      employee = Employee.find_or_create_by!(
        corporate_email: row["email_corporativo"]
      ) do |e|
        e.name = row["nome"]
        e.position = row["cargo"]
        e.role = row["funcao"]
        e.location = row["localidade"]
        e.gender = row["genero"]
        e.generation = row["geracao"]
        e.company_tenure = row["tempo_de_empresa"]
        e.department = department
      end

      SurveyResponse.create!(
        employee: employee,
        interest_in_role: row["Interesse no Cargo"],
        contribution: row["Contribuição"],
        learning_and_development: row["Aprendizado e Desenvolvimento"],
        feedback: row["Feedback"],
        manager_interaction: row["Interação com Gestor"],
        career_clarity: row["Clareza sobre Possibilidades de Carreira"],
        permanence_expectation: row["Expectativa de Permanência"],
        enps: row["eNPS"],
        comment: row["[Aberta] eNPS"],
        responded_at: row["Data da Resposta"]
      )
    end
  end
end
