# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181113073716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.boolean "approved", default: false
    t.index ["team_id"], name: "index_achievements_on_team_id"
  end

  create_table "events", force: :cascade do |t|
    t.text "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pauses", force: :cascade do |t|
    t.bigint "pomodoro_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pomodoro_id"], name: "index_pauses_on_pomodoro_id"
  end

  create_table "pomodoros", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pauses_count", default: 0, null: false
    t.index ["user_id"], name: "index_pomodoros_on_user_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "expected_score"
    t.integer "actual_score"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sprints_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.string "start_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.bigint "pomodoro_achievement_id"
    t.index ["admin_id"], name: "index_teams_on_admin_id"
    t.index ["pomodoro_achievement_id"], name: "index_teams_on_pomodoro_achievement_id"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "achievement_id"
    t.datetime "date_achieved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin"
    t.string "avatar"
    t.bigint "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "achievements", "teams"
  add_foreign_key "pauses", "pomodoros"
  add_foreign_key "pomodoros", "users"
  add_foreign_key "sprints", "users"
  add_foreign_key "teams", "achievements", column: "pomodoro_achievement_id"
  add_foreign_key "teams", "users", column: "admin_id"
  add_foreign_key "users", "teams"
end
