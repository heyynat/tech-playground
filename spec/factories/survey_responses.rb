FactoryBot.define do
  factory :survey_response do
    employee { nil }
    interest_in_role { 1 }
    contribution { 1 }
    learning_and_development { 1 }
    feedback { 1 }
    manager_interaction { 1 }
    career_clarity { 1 }
    permanence_expectation { 1 }
    enps { 1 }
    comment { "MyText" }
    responded_at { "2026-01-12 23:01:56" }
  end
end
