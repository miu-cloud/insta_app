ActiveRecord::Schema.define(version: 2021_02_25_064415) do

  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.text "image"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
    t.bigint "user_id"
    t.index ["message_id"], name: "index_feeds_on_message_id"
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "feeds", "users"
end
