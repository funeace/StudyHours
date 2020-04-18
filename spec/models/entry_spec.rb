require 'rails_helper'

# create_table "entries", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "room_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["room_id"], name: "index_entries_on_room_id"
#   t.index ["user_id"], name: "index_entries_on_user_id"
# end

RSpec.describe Entry, type: :model do
  before do
    @entry = FactoryBot.create(:entry)
  end
  it "必要項目が存在すれば有効" do
    expect(@entry).to be_valid
  end

  it "user_idが存在しなかったら無効" do
    @entry.user_id = ""
    expect(@entry).not_to be_valid
  end

  it "room_idが存在しなかったら無効" do
    @entry.room_id = ""
    expect(@entry).not_to be_valid
  end
end
