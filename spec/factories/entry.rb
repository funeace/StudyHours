# create_table "entries", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "room_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["room_id"], name: "index_entries_on_room_id"
#   t.index ["user_id"], name: "index_entries_on_user_id"
# end

FactoryBot.define do
  factory :entry do
    association :user
    association :room
  end
end
