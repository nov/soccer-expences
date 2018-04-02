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

ActiveRecord::Schema.define(version: 20170312120740) do

  create_table "accounts", force: :cascade do |t|
    t.boolean "admin", default: false
    t.boolean "approved", default: false
    t.string "display_name", null: false
    t.string "email", null: false
    t.datetime "last_logged_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connect_facebooks", force: :cascade do |t|
    t.integer "account_id"
    t.string "identifier", null: false
    t.string "access_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_connect_facebooks_on_identifier", unique: true
  end

  create_table "connect_googles", force: :cascade do |t|
    t.integer "account_id"
    t.string "identifier", null: false
    t.string "access_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_connect_googles_on_identifier", unique: true
  end

  create_table "event_members", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "member_id"], name: "index_event_members_on_event_id_and_member_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.string "location", null: false
    t.integer "cost_from_members_budget", default: 0
    t.integer "cost_from_team_budget", default: 0
    t.integer "event_members_count", default: 0
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "description"
    t.integer "initial_budget", default: 5000, null: false
    t.float "spent_budget", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_members_on_display_name", unique: true
  end

end
