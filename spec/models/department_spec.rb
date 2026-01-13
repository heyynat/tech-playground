require "rails_helper"

RSpec.describe Department, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:department)).to be_valid
    end

    it "is invalid without a name" do
      department = build(:department, name: nil)
      expect(department).not_to be_valid
      expect(department.errors[:name]).to include("can't be blank")
    end
  end
end
