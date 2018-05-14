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

ActiveRecord::Schema.define(version: 2018_05_10_152353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vocabulary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sent_at"
    t.integer "vocabulary_sense_index", default: 0
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
    t.index ["vocabulary_id"], name: "index_subscriptions_on_vocabulary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "messenger_uid"
    t.integer "words_of_the_day", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_read_vocabulary_at"
    t.index ["messenger_uid"], name: "index_users_on_messenger_uid"
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "word"
    t.string "word_class"
    t.jsonb "sense", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word"], name: "index_vocabularies_on_word"
  end

  add_foreign_key "subscriptions", "users"
  add_foreign_key "subscriptions", "vocabularies"
end
