require 'rails_helper'

# create_table "notes", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.string "title", null: false
#   t.text "body", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["title"], name: "index_notes_on_title"
#   t.index ["user_id"], name: "index_notes_on_user_id"
# end

RSpec.describe Note, type: :model do
  before do
    @note = FactoryBot.create(:note)
  end

  it "必要項目が存在していれば有効" do
    expect(@note).to be_valid
  end

  it "user_idが存在していなかったら無効" do
    @note.user_id = ""
    expect(@note).not_to be_valid
  end

  it "titleが存在していなかったら無効" do
    @note.title =""
    expect(@note).not_to be_valid
  end

  it "bodyが存在していなかったら無効" do
    @note.body = ""
    expect(@note).not_to be_valid
  end
end
