require 'rails_helper'

# create_table "study_logs", force: :cascade do |t|
#   t.integer "user_id", null: false
#   t.string "memo"
#   t.date "working_date", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_study_logs_on_user_id"
# end

RSpec.describe StudyLog, type: :model do
  before do
    @study_log = FactoryBot.create(:study_log)
  end

  it "必要項目が存在すれば有効" do
    expect(@study_log).to be_valid
  end

  it "ユーザIDが入っていない場合は無効" do
    @study_log.user_id = ""
    expect(@study_log).not_to be_valid
  end

  it "メモは50文字以下" do
    @study_log.memo = "a"*51
    expect(@study_log).not_to be_valid
  end

  it "作業日が入っていないと無効" do
    @study_log.working_date = ""
    expect(@study_log).not_to be_valid
  end
end
