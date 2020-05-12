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

ActiveRecord::Schema.define(version: 2019_05_07_210431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.text "ac_numbered_list"
    t.text "ac_name"
    t.date "ac_start_date"
    t.date "ac_end_date"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ac_predecessor"
    t.integer "ac_days"
    t.boolean "ac_is_cost"
    t.index ["activity_id"], name: "index_activities_on_activity_id"
  end

  create_table "baselines", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "activity_id"
    t.string "ba_status"
    t.string "ba_type"
    t.integer "ba_amount"
    t.integer "ba_price"
    t.bigint "baseline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "measure_id"
    t.index ["activity_id"], name: "index_baselines_on_activity_id"
    t.index ["baseline_id"], name: "index_baselines_on_baseline_id"
    t.index ["measure_id"], name: "index_baselines_on_measure_id"
    t.index ["project_id"], name: "index_baselines_on_project_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "co_name"
    t.string "co_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cs_users", force: :cascade do |t|
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rol"
  end

  create_table "details", force: :cascade do |t|
    t.float "de_amount"
    t.integer "de_hour"
    t.bigint "collaborator_id"
    t.bigint "equipment_id"
    t.bigint "weather_id"
    t.bigint "qaqc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "de_hours"
    t.bigint "report_id"
    t.index ["collaborator_id"], name: "index_details_on_collaborator_id"
    t.index ["equipment_id"], name: "index_details_on_equipment_id"
    t.index ["qaqc_id"], name: "index_details_on_qaqc_id"
    t.index ["report_id"], name: "index_details_on_report_id"
    t.index ["weather_id"], name: "index_details_on_weather_id"
  end

  create_table "detobs", force: :cascade do |t|
    t.bigint "detail_id"
    t.bigint "observation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_id"], name: "index_detobs_on_detail_id"
    t.index ["observation_id"], name: "index_detobs_on_observation_id"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "en_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "eq_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "helps", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "collaborator_id"
    t.bigint "equipment_id"
    t.bigint "weather_id"
    t.bigint "qaqc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaborator_id"], name: "index_helps_on_collaborator_id"
    t.index ["equipment_id"], name: "index_helps_on_equipment_id"
    t.index ["project_id"], name: "index_helps_on_project_id"
    t.index ["qaqc_id"], name: "index_helps_on_qaqc_id"
    t.index ["weather_id"], name: "index_helps_on_weather_id"
  end

  create_table "manages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_manages_on_project_id"
    t.index ["user_id"], name: "index_manages_on_user_id"
  end

  create_table "measures", force: :cascade do |t|
    t.string "me_name"
    t.string "me_unit"
    t.boolean "me_is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "observations", force: :cascade do |t|
    t.string "ob_name"
    t.integer "ob_type"
    t.string "ob_desc"
    t.text "ob_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "ph_name"
    t.string "ph_src"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_photos_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.text "pr_name"
    t.text "pr_description"
    t.date "pr_start_date"
    t.date "pr_end_date"
    t.float "pr_admon"
    t.float "pr_incidental"
    t.float "pr_indirect_cost"
    t.float "pr_profit"
    t.float "pr_tax_iva"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pr_status"
    t.integer "pr_hours"
    t.boolean "is_cost"
  end

  create_table "qaqcs", force: :cascade do |t|
    t.string "qa_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "realcosts", force: :cascade do |t|
    t.date "re_date"
    t.float "re_value"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_realcosts_on_project_id"
  end

  create_table "reports", force: :cascade do |t|
    t.date "re_date"
    t.float "re_amount"
    t.bigint "activity_id"
    t.bigint "contractor_id"
    t.bigint "controller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "re_status"
    t.integer "pr_hours"
    t.index ["activity_id"], name: "index_reports_on_activity_id"
    t.index ["contractor_id"], name: "index_reports_on_contractor_id"
    t.index ["controller_id"], name: "index_reports_on_controller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "us_name"
    t.integer "us_rol", limit: 2
    t.integer "us_status", limit: 2
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.string "we_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "enterprise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_works_on_enterprise_id"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "activities", "activities"
  add_foreign_key "baselines", "activities"
  add_foreign_key "baselines", "baselines"
  add_foreign_key "baselines", "measures"
  add_foreign_key "baselines", "projects"
  add_foreign_key "details", "collaborators"
  add_foreign_key "details", "equipment"
  add_foreign_key "details", "qaqcs"
  add_foreign_key "details", "reports"
  add_foreign_key "details", "weathers"
  add_foreign_key "detobs", "details"
  add_foreign_key "detobs", "observations"
  add_foreign_key "helps", "collaborators"
  add_foreign_key "helps", "equipment"
  add_foreign_key "helps", "projects"
  add_foreign_key "helps", "qaqcs"
  add_foreign_key "helps", "weathers"
  add_foreign_key "manages", "projects"
  add_foreign_key "manages", "users"
  add_foreign_key "photos", "projects"
  add_foreign_key "realcosts", "projects"
  add_foreign_key "reports", "activities"
  add_foreign_key "works", "enterprises"
  add_foreign_key "works", "users"
end
