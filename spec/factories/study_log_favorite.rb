# create_table "study_log_favorites", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

FactoryBot.define do
  factory :study_log_favorite do
    association :user
    association :study_log
  end
end