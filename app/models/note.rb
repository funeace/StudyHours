class Note < ApplicationRecord
  belongs_to :user
  has_many :note_favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # acts_as_taggable_onを利用するため定義
  acts_as_taggable

  validates :title, presence: true
  validates :body, presence: true
  validate :invalid_note_tag
  validate :invalid_note_tag_size

  def favorited_by?(user)
    note_favorites.where(user_id: user.id).exists?
  end

  # tag_listはgemで行っているため、バリデーションを作成する必要があった
  # 以下でタグが存在しているかチェックを行う(default:0)
  @taglist_count = 0

  def set_taglist_exist(tag_list)
    @taglist_count = tag_list
  end

  def invalid_note_tag
    return unless @taglist_chk

    errors[:base] << 'タグが入力されていません'
  end

  def invalid_note_tag_size
    return unless @taglist_count > 6

    errors[:base] << 'タグは6つまで登録できます'
  end

end
