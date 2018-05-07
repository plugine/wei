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

ActiveRecord::Schema.define(version: 20180506123258) do

  create_table "activities", force: :cascade do |t|
    t.string   "name",              limit: 255,                   null: false
    t.string   "author",            limit: 255
    t.boolean  "enabled",                         default: false
    t.text     "desc",              limit: 65535
    t.text     "consts",            limit: 65535
    t.text     "template",          limit: 65535,                 null: false
    t.string   "qrurl",             limit: 255
    t.integer  "public_account_id", limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "event_key",         limit: 255,   default: ""
  end

  add_index "activities", ["public_account_id"], name: "index_activities_on_public_account_id", using: :btree

  create_table "activities_users", id: false, force: :cascade do |t|
    t.integer "activity_id", limit: 4
    t.integer "user_id",     limit: 4
  end

  add_index "activities_users", ["activity_id", "user_id"], name: "index_activities_users_on_activity_id_and_user_id", using: :btree

  create_table "article_types", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "code",              limit: 255
    t.string   "thumb",             limit: 255
    t.integer  "public_account_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "article_types", ["public_account_id"], name: "index_article_types_on_public_account_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255,                        null: false
    t.date     "expire_at",              default: '2019-04-01'
    t.boolean  "enabled",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crop_users", force: :cascade do |t|
    t.string   "account",         limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.string   "phone",           limit: 255, null: false
    t.integer  "company_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crop_users", ["account"], name: "index_crop_users_on_account", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_type",        limit: 255, null: false
    t.string   "action_type",       limit: 255, null: false
    t.string   "condition",         limit: 255
    t.string   "extra",             limit: 255
    t.integer  "priority",          limit: 4
    t.integer  "public_account_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "events", ["event_type"], name: "index_events_on_event_type", using: :btree
  add_index "events", ["public_account_id"], name: "index_events_on_public_account_id", using: :btree

  create_table "media_resources", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "qiniu_key",         limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "public_account_id", limit: 4
  end

  add_index "media_resources", ["public_account_id"], name: "index_media_resources_on_public_account_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "order_no",      limit: 255,                                        null: false
    t.decimal  "price",                     precision: 8,  scale: 2
    t.string   "type",          limit: 255
    t.string   "real_name",     limit: 255
    t.string   "phone",         limit: 255
    t.integer  "state",         limit: 4
    t.string   "address",       limit: 512
    t.datetime "paid_at"
    t.decimal  "carriage",                  precision: 10, scale: 2, default: 0.0
    t.string   "note",          limit: 512
    t.string   "operator_note", limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",       limit: 4
    t.integer  "crop_user_id",  limit: 4
  end

  add_index "orders", ["order_no"], name: "index_orders_on_order_no", using: :btree
  add_index "orders", ["phone"], name: "index_orders_on_phone", using: :btree
  add_index "orders", ["type", "state"], name: "index_orders_on_type_and_state", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",             limit: 255,                   null: false
    t.string   "code",              limit: 30,                    null: false
    t.text     "content",           limit: 65535,                 null: false
    t.string   "page_type",         limit: 10,    default: "raw"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "public_account_id", limit: 4
    t.integer  "article_type_id",   limit: 4
  end

  add_index "pages", ["article_type_id"], name: "index_pages_on_article_type_id", using: :btree
  add_index "pages", ["public_account_id"], name: "index_pages_on_public_account_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.decimal  "total_fee",                precision: 8, scale: 2
    t.string   "type",       limit: 255
    t.integer  "state",      limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "order_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pay_data",   limit: 512
    t.text     "pay_detail", limit: 65535
  end

  create_table "public_accounts", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.string   "account",    limit: 255,   null: false
    t.string   "appid",      limit: 255,   null: false
    t.string   "appsecret",  limit: 255,   null: false
    t.integer  "company_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "menu_json",  limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.string   "from",              limit: 255,   default: "wechat"
    t.integer  "public_account_id", limit: 4
    t.boolean  "alive"
    t.string   "openid",            limit: 255
    t.string   "nickname",          limit: 191
    t.integer  "sex",               limit: 4
    t.string   "country",           limit: 255
    t.string   "province",          limit: 255
    t.string   "city",              limit: 255
    t.string   "language",          limit: 255
    t.string   "headimgurl",        limit: 255
    t.datetime "subscribe_time"
    t.string   "union_id",          limit: 255
    t.string   "remark",            limit: 255
    t.integer  "groupid",           limit: 4
    t.text     "tagid_list",        limit: 65535
    t.string   "subscribe_scene",   limit: 255
    t.string   "qr_scene",          limit: 255
    t.string   "qr_scene_str",      limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.datetime "dead_at"
  end

  add_index "users", ["openid"], name: "index_users_on_openid", using: :btree
  add_index "users", ["public_account_id"], name: "index_users_on_public_account_id", using: :btree

  create_table "wxpub_pay_configs", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "appid",      limit: 255, null: false
    t.string   "key",        limit: 255, null: false
    t.string   "mch_id",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
