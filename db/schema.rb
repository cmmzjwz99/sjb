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

  create_table "basic_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "verifyfail"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.string "dkxs"
    t.string "dklx"
    t.string "dkqx"
    t.string "dbfs"
    t.string "dblx"
    t.string "hkfs"
    t.string "dkcp"
    t.string "dkje"
    t.string "lsed"
    t.string "zjkje"
    t.string "hkzl"
    t.string "jkyt"
    t.string "hkly"
    t.string "dkqxdw"
    t.datetime "ksrq"
    t.datetime "jsrq"
    t.string "zdr"
    t.datetime "zdrq"
    t.string "sqb"
    t.string "clxxb"
    t.string "cljcb"
    t.string "yybspb"
    t.string "csb"
    t.index ["loan_id"], name: "index_basic_messages_on_loan_id"
  end

  create_table "car_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "verifyfail"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "no"
    t.string "name"
    t.datetime "pgrq"
    t.string "pgjz"
    t.datetime "qsr"
    t.datetime "zzr"
    t.string "cfdz"
    t.string "ypbz"
    t.string "ypdw"
    t.float "zdyl", limit: 24
    t.float "kdjz", limit: 24
    t.float "yyjz", limit: 24
    t.integer "ypsl"
    t.string "dq"
    t.string "pgdw"
    t.string "pgry"
    t.integer "ydgps"
    t.integer "gdgps"
    t.string "clsbm"
    t.string "qcpp"
    t.string "qcxh"
    t.string "qbxhxx"
    t.string "csbs"
    t.datetime "spsj"
    t.datetime "ccrq"
    t.string "xsgl"
    t.string "clys"
    t.string "nsqk"
    t.string "qmqk"
    t.string "gkzk"
    t.string "ghcs"
    t.float "xtpgj", limit: 24
    t.float "pjpgj", limit: 24
    t.string "qcpz"
    t.string "fkfs"
    t.string "fdjhm"
    t.string "gcjk"
    t.datetime "gmsj"
    t.string "gmjg"
    t.string "synx"
    t.string "pl"
    t.index ["loan_id"], name: "index_car_messages_on_loan_id"
  end

  create_table "customer_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "img"
    t.string "style"
    t.bigint "customer_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_message_id"], name: "index_customer_images_on_customer_message_id"
  end

  create_table "customer_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "verifyfail"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.string "dkxs"
    t.string "dklx"
    t.string "dkqx"
    t.string "dbfs"
    t.string "dblx"
    t.string "hkfs"
    t.string "dkcp"
    t.string "dkje"
    t.string "lsed"
    t.string "zjkje"
    t.string "hkzl"
    t.string "jkyt"
    t.string "hkly"
    t.string "dkqxdw"
    t.datetime "ksrq"
    t.datetime "jsrq"
    t.string "zdr"
    t.datetime "zdrq"
    t.index ["loan_id"], name: "index_customer_messages_on_loan_id"
  end

  create_table "instalments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "balance", limit: 24
    t.integer "periods"
    t.boolean "has_repay", default: false
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "overdue_time"
    t.float "gpsfy", limit: 24, default: 0.0
    t.float "gpsllf", limit: 24, default: 0.0
    t.float "jjf", limit: 24, default: 0.0
    t.float "zjfd", limit: 24, default: 0.0
    t.float "fwf", limit: 24, default: 0.0
    t.float "bj", limit: 24, default: 0.0
    t.float "lx", limit: 24, default: 0.0
    t.float "dkye", limit: 24, default: 0.0
    t.index ["loan_id"], name: "index_instalments_on_loan_id"
  end

  create_table "loan_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "verifyfail"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_comments_on_loan_id"
  end

  create_table "loan_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "img"
    t.string "style"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_images_on_loan_id"
  end

  create_table "loans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_verify", default: "verifyfail"
    t.integer "verify_user"
    t.string "customer_verify", default: "verifyfail"
    t.string "car_verify", default: "verifyfail"
    t.boolean "has_pay", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "idcard"
    t.string "name"
    t.string "phone"
    t.string "source"
    t.string "location"
    t.string "basic_verify", default: "verifyfail"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label"
    t.string "nicename"
    t.text "modules"
  end

  create_table "user_areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "zjwz", default: false
    t.boolean "zjsxsz", default: false
    t.boolean "zjsxkq", default: false
    t.boolean "zjsxyc", default: false
    t.boolean "zjhz", default: false
    t.boolean "ahhf", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_areas_on_user_id"
  end

  create_table "user_powers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "input", default: false
    t.boolean "first_verify", default: false
    t.boolean "online_verify", default: false
    t.boolean "customer_verify", default: false
    t.boolean "car_verify", default: false
    t.boolean "user_manage", default: false
    t.boolean "financial", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "totle_loan", default: false
    t.index ["user_id"], name: "index_user_powers_on_user_id"
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

  add_foreign_key "basic_messages", "loans"
  add_foreign_key "car_messages", "loans"
  add_foreign_key "customer_images", "customer_messages"
  add_foreign_key "customer_messages", "loans"
  add_foreign_key "instalments", "loans"
  add_foreign_key "loan_comments", "loans"
  add_foreign_key "loan_images", "loans"
  add_foreign_key "loans", "users"
  add_foreign_key "user_areas", "users"
  add_foreign_key "user_powers", "users"
end
