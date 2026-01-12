# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_01_12_230156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "corporate_email"
    t.string "position"
    t.string "role"
    t.string "location"
    t.string "gender"
    t.string "generation"
    t.string "company_tenure"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporate_email"], name: "index_employees_on_corporate_email", unique: true
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.integer "interest_in_role"
    t.integer "contribution"
    t.integer "learning_and_development"
    t.integer "feedback"
    t.integer "manager_interaction"
    t.integer "career_clarity"
    t.integer "permanence_expectation"
    t.integer "enps"
    t.text "comment"
    t.datetime "responded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_survey_responses_on_employee_id"
    t.index ["enps"], name: "index_survey_responses_on_enps"
  end

  add_foreign_key "employees", "departments"
  add_foreign_key "survey_responses", "employees"
end
