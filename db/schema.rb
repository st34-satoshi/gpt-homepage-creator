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

ActiveRecord::Schema[7.0].define(version: 2023_04_11_123030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.string "ip_address"
    t.string "user_agent"
    t.string "referer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_accesses_on_created_at"
    t.index ["ip_address"], name: "index_accesses_on_ip_address"
  end

  create_table "messages", force: :cascade do |t|
    t.string "uuid"
    t.text "user_message"
    t.text "gpt_message"
    t.string "user_id"
    t.string "reply_token"
    t.integer "access_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["uuid"], name: "index_messages_on_uuid", unique: true
  end

end
