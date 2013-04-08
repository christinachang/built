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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130401175057) do

  create_table "images", :force => true do |t|
    t.string   "image_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "project_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "position"
  end

  create_table "project_users", :id => false, :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "user_id",    :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "live_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "repo_name"
    t.string   "repo_url"
    t.string   "ssh_url"
    t.integer  "watchers"
    t.integer  "forks"
    t.string   "language"
    t.string   "semester_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "github_login"
    t.string   "password_token"
    t.string   "email"
    t.string   "full_name"
    t.string   "github_html_url"
    t.string   "token"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.string   "linkedin_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "avatar_url"
    t.string   "semester_id"
  end

end
