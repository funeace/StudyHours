# create_table "tags", force: :cascade do |t|
#   t.string "name"
#   t.string "color_code"
#   t.datetime "created_at"
#   t.datetime "updated_at"
#   t.integer "taggings_count", default: 0
#   t.index ["name"], name: "index_tags_on_name", unique: true
# end

FactoryBot.define do
  # Gemの要素なので直接指定する
  factory :tag,class: ActsAsTaggableOn::Tag do
    name { 'テストタグ' }
    color_code { '#000000' }
  end
end