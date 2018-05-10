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

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "repay_user_id"
    t.float "wzyj", limit: 24, default: 0.0
    t.float "bxyj", limit: 24, default: 0.0
    t.float "bzj", limit: 24, default: 0.0
    t.float "qt", limit: 24, default: 0.0
    t.float "fxj", limit: 24, default: 0.0
    t.index ["loan_id"], name: "index_instalments_on_loan_id"
  end

  create_table "loan_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "status", default: "verifyfail"
    t.integer "verify_user"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
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

  create_table "loan_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "jkxxyt"
    t.string "htxlh"
    t.string "xb"
    t.string "nl"
    t.string "yddh"
    t.string "hyzk"
    t.string "sfz"
    t.string "xl"
    t.string "zzdh"
    t.string "hjxxdz"
    t.string "xjdz"
    t.string "qsjzsj"
    t.string "gyqsrs"
    t.string "fclb"
    t.string "dwxz"
    t.string "gzdw"
    t.string "sshy"
    t.string "zw"
    t.string "qsgzsj"
    t.string "dwdz"
    t.string "dwdh"
    t.string "jbsr"
    t.string "qtsr"
    t.string "zsr"
    t.string "qs1"
    t.string "qs1_gx"
    t.string "qs1_dh"
    t.string "qs2"
    t.string "qs2_gx"
    t.string "qs2_dh"
    t.string "qs3"
    t.string "qs3_gx"
    t.string "qs3_dh"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bdmc"
    t.string "bdlx"
    t.index ["loan_id"], name: "index_loan_messages_on_loan_id"
  end

  create_table "loans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_verify", default: "verifyfail"
    t.string "review_verify", default: "verifyfail"
    t.string "pay_verify", default: "verifyfail"
    t.boolean "has_pay", default: false
    t.bigint "user_id"
    t.string "name"
    t.datetime "pay_time"
    t.boolean "first_submit", default: false
    t.boolean "review_submit", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "fwf", limit: 24
    t.float "wzyj", limit: 24
    t.float "bxyj", limit: 24
    t.integer "jkqx"
    t.float "jkje", limit: 24
    t.bigint "product_id"
    t.datetime "start_time"
    t.index ["product_id"], name: "index_loans_on_product_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.float "lx", limit: 24, default: 1.0
    t.integer "fqlx", default: 1
    t.integer "sbqs"
    t.float "gpsfy", limit: 24, default: 0.0
    t.float "jjf", limit: 24, default: 0.0
    t.float "gpsllf", limit: 24, default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "bzj", limit: 24, default: 0.0
    t.float "qt", limit: 24, default: 0.0
    t.float "fxj", limit: 24, default: 0.0
    t.boolean "status", default: true
    t.float "sqlx", limit: 24, default: 1.0
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label"
    t.string "nicename"
    t.text "modules"
  end

  create_table "repay_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "no"
    t.float "balance", limit: 24
    t.string "status", default: "unverified"
    t.bigint "instalment_id"
    t.datetime "verify_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remark"
    t.integer "verify_user_id"
    t.index ["instalment_id"], name: "index_repay_logs_on_instalment_id"
  end

  create_table "user_areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_user_areas_on_loan_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "login"
    t.string "password"
    t.string "verify_password"
    t.string "name", default: ""
    t.string "location"
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
    t.integer "identity"
    t.index ["login"], name: "USER_LOGIN"
    t.index ["profile_id"], name: "USER_PROFILE_ID"
  end

  add_foreign_key "instalments", "loans"
  add_foreign_key "loan_comments", "loans"
  add_foreign_key "loan_images", "loans"
  add_foreign_key "loan_messages", "loans"
  add_foreign_key "loans", "products"
  add_foreign_key "loans", "users"
  add_foreign_key "repay_logs", "instalments"
  add_foreign_key "user_areas", "loans"
end
