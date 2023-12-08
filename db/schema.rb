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

ActiveRecord::Schema[7.1].define(version: 2023_12_08_150456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "mythology_id", null: false
    t.bigint "pantheon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mythology_id"], name: "index_gods_on_mythology_id"
    t.index ["pantheon_id"], name: "index_gods_on_pantheon_id"
  end

  create_table "mythologies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pantheons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mythology_id", null: false
    t.string "creativity"
    t.index ["mythology_id"], name: "index_stories_on_mythology_id"
  end

  create_table "story_gods", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "god_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["god_id"], name: "index_story_gods_on_god_id"
    t.index ["story_id"], name: "index_story_gods_on_story_id"
  end

  add_foreign_key "gods", "mythologies"
  add_foreign_key "gods", "pantheons"
  add_foreign_key "stories", "mythologies"
  add_foreign_key "story_gods", "gods"
  add_foreign_key "story_gods", "stories"
end
