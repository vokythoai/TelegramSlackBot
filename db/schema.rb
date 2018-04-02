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

ActiveRecord::Schema.define(version: 20180402084731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bot_responses", force: :cascade do |t|
    t.integer "response_type"
    t.string "message"
    t.string "key_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configs", force: :cascade do |t|
    t.string "config_type"
    t.integer "value"
  end

  create_table "users", force: :cascade do |t|
    t.integer "bot_response_id"
    t.string "user_uid"
    t.integer "status"
    t.string "name"
    t.integer "number_violation", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
