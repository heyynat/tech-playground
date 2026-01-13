FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    corporate_email { Faker::Internet.email }
    department
  end
end
