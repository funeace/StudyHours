require 'rails_helper'

#   create_table "study_log_favorites", force: :cascade do |t|
#   t.integer "study_log_id", null: false
#   t.integer "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   end

RSpec.describe StudyLogFavorite, type: :model do
  before do
    @study_log_favorite = FactoryBot.create(:study_log_favorite)
  end

  it '必要項目が存在すれば有効' do
    # デバッグ
    # p @study_log_favorite.user
    expect(@study_log_favorite).to be_valid
  end

  it 'study_log_idが存在しなければ無効' do
    @study_log_favorite.study_log_id = ""
    expect(@study_log_favorite).not_to be_valid
  end

  it 'user_idが存在しなければ無効' do
    @study_log_favorite.user_id = ""
    expect(@study_log_favorite).not_to be_valid
  end
end
