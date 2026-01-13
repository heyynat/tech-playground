FactoryBot.define do
  factory :survey_response do
    employee
    enps { 9 }
    interest_in_role { 4 }
    contribution { 4 }
  end
end
