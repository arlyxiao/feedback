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

ActiveRecord::Schema.define(:version => 20120420075837) do

  create_table "comments", :force => true do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.integer  "creator_id"
    t.text     "content"
    t.integer  "reply_comment_id"
    t.integer  "reply_comment_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_records", :force => true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_records", ["key"], :name => "index_online_records_on_key"
  add_index "online_records", ["user_id"], :name => "index_online_records_on_user_id"

  create_table "problem_field_data", :force => true do |t|
    t.integer  "problem_report_id"
    t.integer  "problem_field_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_field_types", :force => true do |t|
    t.integer  "problem_field_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_fields", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "field_type"
    t.integer  "problem_type_id"
  end

  create_table "problem_report_attachements", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "report_id"
    t.string   "attachement_file_name"
    t.string   "attachement_content_type"
    t.integer  "attachement_file_size"
    t.datetime "attachement_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_reports", :force => true do |t|
    t.integer  "creator_id"
    t.string   "email"
    t.text     "content"
    t.text     "admin_reply"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_type_id"
  end

  create_table "problem_types", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "creator_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :default => "", :null => false
    t.string   "hashed_password",           :default => "", :null => false
    t.string   "salt",                      :default => "", :null => false
    t.string   "email",                     :default => "", :null => false
    t.string   "sign"
    t.string   "activation_code"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "activated_at"
    t.string   "reset_password_code"
    t.datetime "reset_password_code_until"
    t.datetime "last_login_time"
    t.boolean  "send_invite_email"
    t.integer  "reputation",                :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vote_items", :force => true do |t|
    t.integer  "vote_id"
    t.string   "item_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "vote_result_items", :force => true do |t|
    t.integer  "vote_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote_result_id"
  end

  create_table "vote_results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.integer  "select_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind",         :default => "TEXT"
  end

end
