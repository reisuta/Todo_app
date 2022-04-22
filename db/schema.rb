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

ActiveRecord::Schema.define(version: 2022_04_22_232731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", comment: "カテゴリー", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリー名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", comment: "タスク", force: :cascade do |t|
    t.string "name", null: false, comment: "タスク名"
    t.text "body", null: false, comment: "タスク本文"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "priority", default: 0, null: false, comment: "優先順位"
    t.datetime "ended_at", comment: "終了期限"
    t.integer "status", default: 0, null: false, comment: "タスク状態"
  end

  create_table "tasks_categories", comment: "タスクカテゴリー", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_tasks_categories_on_category_id"
    t.index ["task_id"], name: "index_tasks_categories_on_task_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks_categories", "categories"
  add_foreign_key "tasks_categories", "tasks"
end
