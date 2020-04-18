require 'rails_helper'

# create_table "study_log_details", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "hour", default: 0, null: false
#   t.integer "min", default: 0, null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["study_log_id"], name: "index_study_log_details_on_study_log_id"
# end

RSpec.describe StudyLogDetail, type: :model do
  before do
    @study_log_detail = FactoryBot.create(:study_log_detail)
  end

  it "必要項目が存在すれば有効" do
    expect(@study_log_detail).to be_valid
  end

  it "study_log_idが存在しなかったら無効" do
    @study_log_detail.study_log_id = ""
    expect(@study_log_detail).not_to be_valid
  end

  it "合計時間が0時間0分だったら無効" do
    @study_log_detail.hour = 0
    @study_log_detail.min = 0
    expect(@study_log_detail).not_to be_valid
  end

  it "hourが空白だったら無効" do
    @study_log_detail.hour = ""
    expect(@study_log_detail).not_to be_valid
  end

  it "minが空白だったら無効" do
    @study_log_detail.min = ""
    expect(@study_log_detail).not_to be_valid
  end
end
