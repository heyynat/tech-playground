class Employee < ApplicationRecord
  belongs_to :department
  has_many :survey_responses, dependent: :destroy
end
