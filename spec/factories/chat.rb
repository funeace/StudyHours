# create_table "chats", force: :cascade do |t|
#   t.integer "room_id", null: false
#   t.integer "user_id", null: false
#   t.string "content", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

FactoryBot.define do
  factory :chat do
    association :room
    association :user
    content { "おはよう!!" }
  end
end