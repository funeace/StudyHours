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
  # フォローの通知
  factory :notification_follow, class:Notification do
    association :user
    association :visit, factory: :other_user
    action { "follow" }
    checked  { true } 
  end

  # 学習記録いいねの通知
  factory :notification_study_log_favorite, class:Notification do
    association :user
    association :visit, factory: :other_user
    association :study_log
    action { "study_log_favorite" }
    checked { true }
  end

  # 学習記録コメントの通知
  factory :notification_study_log_comment, class:Notification do
    association :user
    association :visit, factory: :other_user
    association :study_log
    association :study_log_comment
    action { "study_log_comment" }
    checked { true }
  end

  # ノートいいねの通知
  factory :notification_note_favorite, class:Notification do
    association :user
    association :visit, factory: :other_user
    association :note
    action { "note_favorite" }
    checked { true }
  end

  # ノートコメントの通知
  factory :notification_note_comment, class:Notification do
    association :user
    association :visit, factory: :other_user
    association :note
    association :note_comment
    action { "note_comment" }
    checked { true }
  end

  # 未確認
  factory :notification_check, class:Notification do
    association :user
    association :visit, factory: :other_user
    action { "follow" }
    checked { false }
  end

end
