class Note < ApplicationRecord
  belongs_to :user
  has_many :note_favorites,dependent: :destroy
  has_many :note_comments,dependent: :destroy
  has_many :notifications, dependent: :destroy


  # tagsテーブルとの関連付けを作成 defaultは tag_list
  acts_as_taggable

  # titleが空白じゃないことを確認
  validates :title,presence: true
  # bodyが空白じゃないことを確認
  validates :body,presence: true

  # 既にいいねを押しているかのチェック
  def favorited_by?(user)
    self.note_favorites.where(user_id: user.id).exists?
  end

end
