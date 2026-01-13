require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:employee)).to be_valid
    end

    it "is invalid without a name" do
      employee = build(:employee, name: nil)
      expect(employee).not_to be_valid
      expect(employee.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a corporate_email" do
      employee = build(:employee, corporate_email: nil)
      expect(employee).not_to be_valid
      expect(employee.errors[:corporate_email]).to include("can't be blank")
    end

    it "validates uniqueness of corporate_email" do
      create(:employee, corporate_email: "test@example.com")
      duplicate = build(:employee, corporate_email: "test@example.com")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:corporate_email]).to include("has already been taken")
    end
  end

  describe "associations" do
    it "belongs to a department" do
      association = described_class.reflect_on_association(:department)
      expect(association.macro).to eq :belongs_to
    end

    it "has many survey_responses" do
      association = described_class.reflect_on_association(:survey_responses)
      expect(association.macro).to eq :has_many
    end
  end
end
