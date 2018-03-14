# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180314152041) do

  create_table "activities", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "author",        limit: 255
    t.text     "code_template", limit: 65535
    t.text     "constants",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["name"], name: "index_activities_on_name", using: :btree

  create_table "public_accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "appid",      limit: 50,  null: false
    t.string   "appsecret",  limit: 80,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account",    limit: 255
  end

  add_index "public_accounts", ["name"], name: "index_public_accounts_on_name", unique: true, using: :btree

  create_table "user_admin_users", force: :cascade do |t|
    t.string "account",         limit: 50,  null: false
    t.string "password_digest", limit: 100, null: false
  end

end
