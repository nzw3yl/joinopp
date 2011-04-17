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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110417052744) do

  create_table "commitments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "undertaking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commitments", ["undertaking_id"], :name => "index_commitments_on_undertaking_id"
  add_index "commitments", ["user_id", "undertaking_id"], :name => "index_commitments_on_user_id_and_undertaking_id", :unique => true
  add_index "commitments", ["user_id"], :name => "index_commitments_on_user_id"

  create_table "undertakings", :force => true do |t|
    t.string   "title"
    t.text     "description",   :limit => 255
    t.integer  "status_id"
    t.text     "success_if",    :limit => 255
    t.integer  "visibility_id"
    t.string   "access_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "welcome_code"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
