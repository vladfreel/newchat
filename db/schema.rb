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

ActiveRecord::Schema.define(version: 20171129082708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ["author_type", "author_id"], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index ["resource_type", "resource_id"], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: "", null: false
    t.string 'encrypted_password', default: "", null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_categories_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'com_email'
    t.text 'body'
    t.bigint 'image_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['image_id'], name: 'index_comments_on_image_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'action_type'
    t.string 'orig_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_events_on_user_id'
  end

  create_table 'images', force: :cascade do |t|
    t.string 'path'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.string 'img'
    t.index ['category_id'], name: 'index_images_on_category_id'
    t.index ['user_id'], name: 'index_images_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'image_id'
    t.bigint 'user_id'
    t.index ['image_id'], name: 'index_likes_on_image_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'subs', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_subs_on_category_id'
    t.index ['user_id'], name: 'index_subs_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: ''
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'provider'
    t.string 'uid'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.integer 'cached_failed_attempts', default: 0
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'avatar'
    t.string 'login'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
  end

  add_foreign_key 'categories', 'users'
  add_foreign_key 'comments', 'images'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'events', 'users'
  add_foreign_key 'images', 'categories'
  add_foreign_key 'images', 'users'
  add_foreign_key 'likes', 'images'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'subs', 'categories'
  add_foreign_key 'subs', 'users'
end
