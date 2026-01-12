class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :corporate_email
      t.string :position
      t.string :role
      t.string :location
      t.string :gender
      t.string :generation
      t.string :company_tenure
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
