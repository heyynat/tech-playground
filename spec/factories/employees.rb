FactoryBot.define do
  factory :employee do
    name { "MyString" }
    corporate_email { "MyString" }
    position { "MyString" }
    role { "MyString" }
    location { "MyString" }
    gender { "MyString" }
    generation { "MyString" }
    company_tenure { "MyString" }
    department { nil }
  end
end
