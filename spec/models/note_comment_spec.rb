require 'rails_helper'

# create_table "note_comments", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.integer "note_id", null: false
#   t.string "comment", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe NoteComment, type: :model do
  before do
    @note_comment = FactoryBot.create(:note_comment)
  end

  it "必要項目が存在していれば有効" do
    expect(@note_comment).to be_valid
  end

  it "user_idが存在していなければ無効" do
    @note_comment.user_id = ""
    expect(@note_comment).not_to be_valid
  end

  it "note_idが存在していなければ無効" do
    @note_comment.note_id = ""
    expect(@note_comment).not_to be_valid
  end

  it "commentがが存在していなければ無効" do
    @note_comment.comment = ""
    expect(@note_comment).not_to be_valid
  end
end
