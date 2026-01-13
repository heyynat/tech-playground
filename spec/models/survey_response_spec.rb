require 'rails_helper'

RSpec.describe SurveyResponse, type: :model do
  describe 'validations' do
    let(:employee) { create(:employee) }
    subject { build(:survey_response, employee: employee) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'validates LIKERT_RANGE fields (1-5)' do
      # Valid values
      subject.interest_in_role = 3
      subject.contribution = 5
      expect(subject).to be_valid

      # Invalid values
      subject.interest_in_role = 0
      expect(subject).not_to be_valid

      subject.interest_in_role = 6
      expect(subject).not_to be_valid
    end

    it 'validates enps range (0-10)' do
      subject.enps = 5
      expect(subject).to be_valid

      subject.enps = 11
      expect(subject).not_to be_valid

      subject.enps = -1
      expect(subject).not_to be_valid
    end

    it 'requires employee association' do
      subject.employee = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an employee' do
      association = SurveyResponse.reflect_on_association(:employee)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe '.enps_score' do
    context 'with no responses' do
      it 'returns 0' do
        expect(SurveyResponse.enps_score).to eq(0)
      end
    end

    context 'with all promoters' do
      before { create_list(:survey_response, 10, enps: 9) }

      it 'returns 100' do
        expect(SurveyResponse.enps_score).to eq(100)
      end
    end

    context 'with all detractors' do
      before { create_list(:survey_response, 10, enps: 3) }

      it 'returns -100' do
        expect(SurveyResponse.enps_score).to eq(-100)
      end
    end

    context 'with mixed responses' do
      before do
        create_list(:survey_response, 5, enps: 9)  # Promoters
        create_list(:survey_response, 3, enps: 7)  # Passives
        create_list(:survey_response, 2, enps: 4)  # Detractors
      end

      it 'calculates correct score' do
        # (50% - 20%) * 100 = 30
        expect(SurveyResponse.enps_score).to eq(30)
      end
    end
  end
end

