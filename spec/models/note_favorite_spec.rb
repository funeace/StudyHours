require 'rails_helper'

# create_table "note_favorites", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.integer "note_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe NoteFavorite, type: :model do
  before do
    @note_favorite = FactoryBot.create(:note_favorite)
  end

  it "必要項目が存在していれば有効" do
    expect(@note_favorite).to be_valid
  end

  it "user_idが存在しなければ無効" do
    @note_favorite.user_id = ""
    expect(@note_favorite).not_to be_valid
  end

  it "note_idが存在しなければ無効" do
    @note_favorite.note_id = ""
    expect(@note_favorite).not_to be_valid
  end
end
