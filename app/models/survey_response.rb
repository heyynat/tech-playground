class SurveyResponse < ApplicationRecord
  belongs_to :employee

  LIKERT_RANGE = (1..5)

  validates :interest_in_role,
            :contribution,
            :learning_and_development,
            :feedback,
            :manager_interaction,
            :career_clarity,
            :permanence_expectation,
            inclusion: { in: LIKERT_RANGE }

  validates :enps, inclusion: { in: 0..10 }

  def self.enps_score
    total = count
    return 0 if total.zero?

    promoters = where(enps: 9..10).count
    detractors = where(enps: 0..6).count

    ((promoters - detractors).to_f / total * 100).round
  end
end
