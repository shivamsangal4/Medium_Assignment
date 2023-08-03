# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_03_113350) do
  create_table "comments", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "drafts", force: :cascade do |t|
    t.integer "user_id"
    t.string "post_img"
    t.string "title"
    t.string "topic"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drafts_on_user_id"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "user_follower_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_follower_id"], name: "index_followings_on_user_follower_id"
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.string "post_img"
    t.string "title"
    t.string "topic"
    t.date "post_date"
    t.text "text"
    t.integer "number_likes"
    t.integer "number_comm"
    t.integer "number_of_views"
    t.integer "total_reading_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "revisions_history", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "time_stamp", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_revisions_history_on_post_id"
    t.index ["user_id"], name: "index_revisions_history_on_user_id"
  end

  create_table "save_for_later", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "time_stamp", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_save_for_later_on_post_id"
    t.index ["user_id"], name: "index_save_for_later_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "credits"
    t.integer "view_count"
    t.date "purchased_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "user_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "drafts", "users"
  add_foreign_key "followings", "users"
  add_foreign_key "followings", "users", column: "user_follower_id"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "revisions_history", "posts"
  add_foreign_key "revisions_history", "users"
  add_foreign_key "save_for_later", "posts"
  add_foreign_key "save_for_later", "users"
  add_foreign_key "subscriptions", "users"
end
