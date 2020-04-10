class StudyLog < ApplicationRecord
  belongs_to :user
  has_many :study_log_details, dependent: :destroy
  accepts_nested_attributes_for :study_log_details
  has_many :study_log_favorites ,dependent: :destroy
  has_many :study_log_comments ,dependent: :destroy

  acts_as_taggable

  # 作業日が入力されている
  validates :working_date,presence: true
  # ユーザIDが存在していることを確認
  validates :user_id,presence: true
  # memoは100文字まで
  validates :memo,length: {maximum: 100}

  # 既にいいね ボタンを押しているか確認
  def favorited_by?(user)
    self.study_log_favorites.where(user_id: user.id).exists?
  end

end
