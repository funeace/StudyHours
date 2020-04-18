require 'rails_helper'

# create_table "study_log_comments", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "user_id", null: false
#   t.string "comment", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe StudyLogComment, type: :model do
  before do
    @study_log_comment = FactoryBot.create(:study_log_comment)
  end

  it "必要項目が存在すれば有効" do
    expect(@study_log_comment).to be_valid
  end

  it "study_log_idが存在しなかったら無効" do
    @study_log_comment.study_log_id = ""
    expect(@study_log_comment).not_to be_valid
  end

  it "user_idが存在しなかったら無効" do
    @study_log_comment.user_id = ""
    expect(@study_log_comment).not_to be_valid
  end

  it "commentが存在しなかったら無効" do
    @study_log_comment.comment = ""
    expect(@study_log_comment).not_to be_valid
  end

end
