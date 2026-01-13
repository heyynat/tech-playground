require 'rails_helper'

RSpec.describe SurveyResponse, type: :model do
  describe 'validations' do
    let(:employee) { create(:employee) }
    subject { build(:survey_response, employee: employee) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without interest_in_role' do
      subject.interest_in_role = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:interest_in_role]).to include("can't be blank")
    end

    it 'is invalid without contribution' do
      subject.contribution = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:contribution]).to include("can't be blank")
    end

    it 'validates inclusion of enps in 0..10' do
      subject.enps = 11
      expect(subject).not_to be_valid

      subject.enps = -1
      expect(subject).not_to be_valid

      subject.enps = 5
      expect(subject).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an employee' do
      association = SurveyResponse.reflect_on_association(:employee)
      expect(association.macro).to eq :belongs_to
    end
  end
end
