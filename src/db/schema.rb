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

ActiveRecord::Schema[7.1].define(version: 2025_04_07_020527) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "list_shares", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id", "user_id"], name: "index_list_shares_on_list_id_and_user_id", unique: true
    t.index ["list_id"], name: "index_list_shares_on_list_id"
    t.index ["user_id"], name: "index_list_shares_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "public_uid", null: false
    t.bigint "owner_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_user_id"], name: "index_lists_on_owner_user_id"
    t.index ["public_uid"], name: "index_lists_on_public_uid", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "completed", default: false, null: false
    t.datetime "completed_at"
    t.bigint "completed_by_user_id"
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_by_user_id"], name: "index_tasks_on_completed_by_user_id"
    t.index ["list_id"], name: "index_tasks_on_list_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "list_shares", "lists"
  add_foreign_key "list_shares", "users"
  add_foreign_key "lists", "users", column: "owner_user_id"
  add_foreign_key "tasks", "lists"
  add_foreign_key "tasks", "users", column: "completed_by_user_id"
end
