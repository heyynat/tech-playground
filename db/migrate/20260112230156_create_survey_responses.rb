class CreateSurveyResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :survey_responses do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :interest_in_role
      t.integer :contribution
      t.integer :learning_and_development
      t.integer :feedback
      t.integer :manager_interaction
      t.integer :career_clarity
      t.integer :permanence_expectation
      t.integer :enps
      t.text :comment
      t.datetime :responded_at

      t.timestamps
    end

    add_index :employees, :corporate_email, unique: true
    add_index :survey_responses, :enps
  end
end
