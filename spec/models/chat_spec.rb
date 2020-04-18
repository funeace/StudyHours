require 'rails_helper'

# create_table "chats", force: :cascade do |t|
#   t.integer "room_id", null: false
#   t.integer "user_id", null: false
#   t.string "content", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe Chat, type: :model do
  before do
    @chat = FactoryBot.create(:chat)
  end

  it "必要項目が存在すれば有効" do
    expect(@chat).to be_valid
  end

  it "room_idが存在しなかったら無効" do
    @chat.room_id = ""
    expect(@chat).not_to be_valid
  end

  it "user_idが存在しなかったら無効" do
    @chat.user_id = ""
    expect(@chat).not_to be_valid
  end

  it "contentが存在しなかったら無効" do
    @chat.content = ""
    expect(@chat).not_to be_valid
  end
end
