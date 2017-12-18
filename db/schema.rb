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

ActiveRecord::Schema.define(version: 2017082414512011) do

  create_table "car_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "unverified"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_car_messages_on_loan_id"
  end

  create_table "customer_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "unverified"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_customer_messages_on_loan_id"
  end

  create_table "instalments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "balance", limit: 24
    t.integer "periods"
    t.boolean "has_repay", default: false
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_instalments_on_loan_id"
  end

  create_table "loan_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "unverified"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_comments_on_loan_id"
  end

  create_table "loans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_verify", default: "unverified"
    t.integer "verify_user"
    t.string "customer_verify", default: "unverified"
    t.string "car_verify", default: "unverified"
    t.boolean "has_pay", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "idcard"
    t.string "name"
    t.string "phone"
    t.string "source"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label"
    t.string "nicename"
    t.text "modules"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "login"
    t.string "password"
    t.string "verify_password"
    t.string "idcard", default: ""
    t.string "email", default: ""
    t.string "name", default: ""
    t.string "real_name", default: ""
    t.integer "sex", limit: 1, default: 0
    t.string "channel"
    t.string "phone"
    t.string "location", default: ""
    t.string "slogan", default: ""
    t.integer "level", default: 0
    t.decimal "score", precision: 10, default: "0"
    t.integer "profile_id"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.string "text_filter_id", default: "1"
    t.string "state", default: "active"
    t.datetime "last_connection"
    t.text "settings"
    t.integer "resource_id"
    t.float "latitude", limit: 24, default: 0.0
    t.float "longitude", limit: 24, default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idcard"], name: "USER_IDCARD"
    t.index ["login"], name: "USER_LOGIN"
    t.index ["phone"], name: "USER_PHONE"
    t.index ["profile_id"], name: "USER_PROFILE_ID"
  end

  add_foreign_key "car_messages", "loans"
  add_foreign_key "customer_messages", "loans"
  add_foreign_key "instalments", "loans"
  add_foreign_key "loan_comments", "loans"
  add_foreign_key "loans", "users"
end
