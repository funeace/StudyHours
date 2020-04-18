# create_table "study_log_details", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "hour", default: 0, null: false
#   t.integer "min", default: 0, null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["study_log_id"], name: "index_study_log_details_on_study_log_id"
# end

FactoryBot.define do
  factory :study_log_detail do
    association :study_log
    hour { 3 }
    min { 30 }
  end
end