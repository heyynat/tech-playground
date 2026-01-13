FactoryBot.define do
  factory :survey_response do
    employee
    interest_in_role { rand(1..5) }
    contribution { rand(1..5) }
    learning_and_development { rand(1..5) }
    feedback { rand(1..5) }
    manager_interaction { rand(1..5) }
    career_clarity { rand(1..5) }
    permanence_expectation { rand(1..5) }
    enps { rand(0..10) }
    comment { Faker::Lorem.paragraph }
    responded_at { Faker::Date.backward(days: 30) }
  end
end
