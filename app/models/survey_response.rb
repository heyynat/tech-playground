class SurveyResponse < ApplicationRecord
  belongs_to :employee

  validates :enps, inclusion: { in: 0..10 }
  validates :interest_in_role, :contribution, presence: true
end
