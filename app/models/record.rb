class Record < ApplicationRecord
  belongs_to :user
  has_many :record_details, dependent: :destroy
  has_many :record_favorites ,dependent: :destroy
  has_many :record_comments ,dependent: :destroy

  # 既にいいね ボタンを押しているか確認
  def favorited_by?(user)
    self.record_favorites.where(user_id: user.id).exists?
  end
end