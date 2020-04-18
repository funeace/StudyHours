# create_table "relationships", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.integer "follow_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["follow_id"], name: "index_relationships_on_follow_id"
#   t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
#   t.index ["user_id"], name: "index_relationships_on_user_id"
# end

FactoryBot.define do
  factory :relationships do
    association :user
    follow_id { 2 }
  end
end