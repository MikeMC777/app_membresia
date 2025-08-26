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

ActiveRecord::Schema[7.1].define(version: 2025_08_06_223148) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "attendance_confirmations", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "meeting_id", null: false
    t.boolean "confirmed"
    t.integer "attendance_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_attendance_confirmations_on_deleted_at"
    t.index ["meeting_id"], name: "index_attendance_confirmations_on_meeting_id"
    t.index ["member_id"], name: "index_attendance_confirmations_on_member_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "event_id", null: false
    t.integer "attendance_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_attendances_on_deleted_at"
    t.index ["event_id"], name: "index_attendances_on_event_id"
    t.index ["member_id"], name: "index_attendances_on_member_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "event_type"
    t.string "location"
    t.string "image_url"
    t.string "video_url"
    t.datetime "start_date"
    t.datetime "due_date"
    t.datetime "publication_date"
    t.integer "order"
    t.boolean "banner"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.string "url"
    t.bigint "folder_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_file_uploads_on_deleted_at"
    t.index ["folder_id"], name: "index_file_uploads_on_folder_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.bigint "team_id", null: false
    t.bigint "parent_folder_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_folders_on_deleted_at"
    t.index ["parent_folder_id"], name: "index_folders_on_parent_folder_id"
    t.index ["team_id"], name: "index_folders_on_team_id"
  end

  create_table "manuals", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.integer "type"
    t.string "url"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_manuals_on_deleted_at"
    t.index ["team_id"], name: "index_manuals_on_team_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "title"
    t.datetime "date"
    t.integer "mode"
    t.string "url"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_meetings_on_deleted_at"
    t.index ["team_id"], name: "index_meetings_on_team_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "first_surname"
    t.string "second_surname"
    t.string "email"
    t.string "phone"
    t.integer "status"
    t.date "birth_date"
    t.date "baptism_date"
    t.integer "marital_status"
    t.integer "gender"
    t.date "wedding_date"
    t.date "membership_date"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_members_on_deleted_at"
  end

  create_table "minutes", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.string "title"
    t.text "agenda"
    t.text "development"
    t.datetime "ending_time"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_minutes_on_deleted_at"
    t.index ["meeting_id"], name: "index_minutes_on_meeting_id"
  end

  create_table "monthly_schedules", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "team_id", null: false
    t.string "scheduled_month"
    t.string "status"
    t.date "due_date"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_monthly_schedules_on_deleted_at"
    t.index ["team_id"], name: "index_monthly_schedules_on_team_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_permissions_on_deleted_at"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_role_permissions_on_deleted_at"
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.integer "scope"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
  end

  create_table "task_comments", force: :cascade do |t|
    t.text "body"
    t.bigint "task_id", null: false
    t.bigint "member_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_task_comments_on_deleted_at"
    t.index ["member_id"], name: "index_task_comments_on_member_id"
    t.index ["task_id"], name: "index_task_comments_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "monthly_schedule_id"
    t.date "start_date"
    t.date "due_date"
    t.bigint "created_by_id", null: false
    t.bigint "assigned_to_id"
    t.integer "status", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_tasks_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["deleted_at"], name: "index_tasks_on_deleted_at"
    t.index ["monthly_schedule_id"], name: "index_tasks_on_monthly_schedule_id"
  end

  create_table "team_roles", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "team_id", null: false
    t.bigint "role_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_team_roles_on_deleted_at"
    t.index ["member_id"], name: "index_team_roles_on_member_id"
    t.index ["role_id"], name: "index_team_roles_on_role_id"
    t.index ["team_id"], name: "index_team_roles_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_teams_on_deleted_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_user_roles_on_deleted_at"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id", null: false
    t.datetime "deleted_at"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "attendance_confirmations", "meetings"
  add_foreign_key "attendance_confirmations", "members"
  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "members"
  add_foreign_key "file_uploads", "folders"
  add_foreign_key "folders", "folders", column: "parent_folder_id"
  add_foreign_key "folders", "teams"
  add_foreign_key "manuals", "teams"
  add_foreign_key "meetings", "teams"
  add_foreign_key "minutes", "meetings"
  add_foreign_key "monthly_schedules", "teams"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "task_comments", "members"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "tasks", "members", column: "assigned_to_id"
  add_foreign_key "tasks", "members", column: "created_by_id"
  add_foreign_key "tasks", "monthly_schedules"
  add_foreign_key "team_roles", "members"
  add_foreign_key "team_roles", "roles"
  add_foreign_key "team_roles", "teams"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "members"
end
