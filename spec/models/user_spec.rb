require 'rails_helper'

  # create_table "users", force: :cascade do |t|
  #   t.string "email", default: "", null: false
  #   t.string "encrypted_password", default: "", null: false
  #   t.string "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.integer "sign_in_count", default: 0, null: false
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.string "current_sign_in_ip"
  #   t.string "last_sign_in_ip"
  #   t.string "name", null: false
  #   t.integer "goal_hour", default: 0, null: false
  #   t.integer "goal_minute", default: 0, null: false
  #   t.string "provider"
  #   t.string "uid"
  #   t.string "meta"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.string "profile_image_id"
  #   t.string "introduction"
  #   t.index ["email"], name: "index_users_on_email", unique: true
  #   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  # end

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
