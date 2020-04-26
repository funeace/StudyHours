require 'rails_helper'

  # create_table "study_logs", force: :cascade do |t|
  #   t.integer "user_id", null: false
  #   t.string "memo"
  #   t.date "working_date", null: false
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.integer "hour", default: 0, null: false
  #   t.integer "minute", default: 0, null: false
  #   t.index ["user_id"], name: "index_study_logs_on_user_id"
  # end

RSpec.describe StudyLog, type: :model do
  let!(:study_log){ create(:study_log) }

  it "必要項目が存在すれば有効" do
    expect(study_log).to be_valid
  end

  it "ユーザIDが入っていない場合は無効" do
    study_log.user_id = ""
    expect(study_log).not_to be_valid
  end

  it "時間(hour)がnullの場合は無効" do
    study_log.hour = ""
    expect(study_log).not_to be_valid
  end

  it "時間（minute）がnullの場合は無効" do
    study_log.minute = ""
    expect(study_log).not_to be_valid
  end

  it "時間の合計が0の場合は無効" do
    study_log.hour = 0
    study_log.minute = 0
    expect(study_log).not_to be_valid
  end

  it "学習日が未来の場合は無効" do
    study_log.working_date = ""
    expect(study_log).not_to be_valid
  end

  it "メモは50文字以下" do
    study_log.memo = "a"*51
    expect(study_log).not_to be_valid
  end

  it "作業日が入っていないと無効" do
    study_log.working_date = ""
    expect(study_log).not_to be_valid
  end
end
