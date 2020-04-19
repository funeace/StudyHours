# create_table "study_log_comments", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "user_id", null: false
#   t.string "comment", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

FactoryBot.define do
  factory :study_log_comment do
    association :study_log
    association :user
    comment {"てすてすてす"}
  end
end