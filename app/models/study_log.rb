class StudyLog < ApplicationRecord
  belongs_to :user
  has_many :study_log_details, dependent: :destroy
  accepts_nested_attributes_for :study_log_details
  has_many :study_log_favorites ,dependent: :destroy
  has_many :study_log_comments ,dependent: :destroy
  has_many :notifications, dependent: :destroy

  acts_as_taggable

  # 作業日が入力されている
  validates :working_date,presence: true
  validate :valid_working_date
  # ユーザIDが存在していることを確認
  validates :user_id,presence: true
  # memoは50文字まで
  validates :memo,length: {maximum: 50}
  validate :valid_study_tag

  # 既にいいね ボタンを押しているか確認
  def favorited_by?(user)
    self.study_log_favorites.where(user_id: user.id).exists?
  end

  # タグが存在しているかチェックするインスタンス変数を定義(default:false)
  @taglist_chk = false

  # 画面から受け取ったパラメータのtag_listが存在しなければtaglist_chkをtrueに変更する
  def set_taglist_exist(tag_list)
    if tag_list == ""
      @taglist_chk = true
    else
      @taglist_chk = false
    end
  end

  # 実際のバリデーションを行うメソッド
  def valid_study_tag
    if @taglist_chk
      errors[:base] << "学習内容が入力されていません"
    end
  end

private
  def valid_working_date
    if working_date > Date.today
      errors[:base] << "未来日は入力できません"
    end
  end
end
