class AddDatabaseConstraints < ActiveRecord::Migration[8.0]
  def up
    change_column_null :survey_responses, :employee_id, false
    change_column_null :survey_responses, :enps, false
    
    execute <<-SQL
      DELETE FROM survey_responses
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM survey_responses
        GROUP BY employee_id, responded_at
      );
    SQL
    
    add_index :survey_responses, [:employee_id, :responded_at], 
              unique: true, 
              name: 'idx_unique_employee_response_date'
  end

  def down
    remove_index :survey_responses, name: 'idx_unique_employee_response_date'
    change_column_null :survey_responses, :employee_id, true
    change_column_null :survey_responses, :enps, true
  end
end

