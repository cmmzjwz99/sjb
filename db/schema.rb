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

ActiveRecord::Schema.define(version: 20180518031925) do

  create_table "games", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.float "odds1", limit: 24
    t.float "odds2", limit: 24
    t.integer "category"
    t.integer "status"
    t.bigint "match_id"
    t.float "odds3", limit: 24
    t.string "name1"
    t.string "name2"
    t.string "name3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "win_team"
    t.index ["match_id"], name: "index_games_on_match_id"
  end

  create_table "matchs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "team1"
    t.string "team2"
    t.integer "score1"
    t.integer "score2"
    t.integer "status"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "odds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "home_team"
    t.string "away_team"
    t.string "rule"
    t.float "home_odd", limit: 24
    t.float "away_odd", limit: 24
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "point", limit: 24
    t.float "get_point", limit: 24
    t.float "odds", limit: 24
    t.integer "team"
    t.integer "status"
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_orders_on_game_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "payment_type"
    t.float "balance", limit: 24
    t.integer "status"
    t.string "no"
    t.bigint "user_id"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label"
    t.string "nicename"
    t.text "modules"
  end

  create_table "user_payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "alipay_status"
    t.string "alipay_qr"
    t.string "alipay_name"
    t.boolean "wechat_status"
    t.string "wechat_qr"
    t.string "wechat_name"
    t.boolean "bank_status"
    t.string "bank_no"
    t.string "bank_name"
    t.string "bank_user"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_payments_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "login"
    t.string "password"
    t.string "verify_password"
    t.string "name", default: ""
    t.integer "profile_id"
    t.integer "father_id"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.string "state", default: "active"
    t.datetime "last_connection"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "points", limit: 24, default: 0.0
    t.boolean "add_agent", default: false
    t.index ["login"], name: "USER_LOGIN"
    t.index ["profile_id"], name: "USER_PROFILE_ID"
  end

end
