# create_table "notes", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.string "title", null: false
#   t.text "body", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["title"], name: "index_notes_on_title"
#   t.index ["user_id"], name: "index_notes_on_user_id"
# end

FactoryBot.define do
  factory :note do
    association :user
    title { "actioncableの使い方" }
    body { "テストテストテストテストテストテストテストテストテスト" }
  end
end