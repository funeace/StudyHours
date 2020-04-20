  # create_table "notifications", force: :cascade do |t|
  #   t.integer "user_id", null: false
  #   t.integer "visit_id", null: false
  #   t.integer "study_log_id"
  #   t.integer "study_log_comment_id"
  #   t.integer "note_id"
  #   t.integer "note_comment_id"
  #   t.string "action", default: "", null: false
  #   t.boolean "checked", default: false, null: false
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end
FactoryBot.define do
  factory :notification do
    association :user
    association :visit, factory: :other_user
    action { "follow" }
  end
end
