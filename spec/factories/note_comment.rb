# create_table "note_comments", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.integer "note_id", null: false
#   t.string "comment", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
FactoryBot.define do
  factory :note_comment do
    association :user
    association :note
    comment { "てすてすてすてす" }
  end
end
