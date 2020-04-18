# create_table "study_logs", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.string "memo"
#   t.date "working_date", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_study_logs_on_user_id"
# end
FactoryBot.define do
  factory :study_log do
    association :user
    working_date {Date.today}
    memo {"頑張りました"}
  end
end