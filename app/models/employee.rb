class Employee < ApplicationRecord
  belongs_to :department
  has_many :survey_responses, dependent: :destroy

  validates :name, presence: true
  validates :corporate_email, presence: true, uniqueness: true
end
