require 'rails_helper'

  # create_table "notifications", force: :cascade do |t|
  #   t.integer "user_id", null: false
  #   t.integer "visit_id", null: false
  #   t.integer "study_log_id"
  #   t.integer "study_log_comment_id"
  #   t.integer "note_id"
  #   t.integer "note_comment_id"
  #   t.string "action", default: "", null: false
  #   t.boolean "checked", default: false, null: false
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end
RSpec.describe Notification, type: :model do
    let!(:notification){ create(:notification_follow) }
  it "必要項目が存在していれば有効" do
    expect(notification).to be_valid
  end
  it "user_idが存在していなければ無効" do
    notification.user_id = ""
    expect(notification).not_to be_valid
  end
  it "visit_idが存在していなければ無効" do
    notification.visit_id = ""
    expect(notification).not_to be_valid
  end
  it "checkedが存在していなければ無効" do
    notification.checked = ""
    expect(notification).not_to be_valid
  end

  it "actionが存在していなければ無効" do
    notification.action = ""
    expect(notification).not_to be_valid
  end
end
