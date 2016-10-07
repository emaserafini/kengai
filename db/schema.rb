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

ActiveRecord::Schema.define(version: 20161007090540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "sensors", force: :cascade do |t|
    t.string   "type",             null: false
    t.float    "value"
    t.string   "scale"
    t.datetime "value_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "thermostat_id", null: false
    t.boolean  "admin",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["thermostat_id"], name: "index_subscribers_on_thermostat_id", using: :btree
    t.index ["user_id"], name: "index_subscribers_on_user_id", using: :btree
  end

  create_table "thermostats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.uuid     "uuid",                              null: false
    t.uuid     "access_token",                      null: false
    t.boolean  "enabled",                           null: false
    t.integer  "temperature_id",                    null: false
    t.integer  "humidity_id",                       null: false
    t.integer  "status",                            null: false
    t.integer  "program_status",                    null: false
    t.datetime "started_at"
    t.float    "offset_temperature",                null: false
    t.integer  "minimum_run",                       null: false
    t.float    "manual_program_target_temperature", null: false
    t.index ["access_token"], name: "index_thermostats_on_access_token", unique: true, using: :btree
    t.index ["humidity_id"], name: "index_thermostats_on_humidity_id", using: :btree
    t.index ["temperature_id"], name: "index_thermostats_on_temperature_id", using: :btree
    t.index ["uuid"], name: "index_thermostats_on_uuid", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "subscribers", "thermostats"
  add_foreign_key "subscribers", "users"
end
