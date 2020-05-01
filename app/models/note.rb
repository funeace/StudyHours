class Note < ApplicationRecord
  belongs_to :user
  has_many :note_favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # tagsテーブルとの関連付けを作成 defaultは tag_list
  acts_as_taggable

  # titleが空白じゃないことを確認
  validates :title, presence: true
  # bodyが空白じゃないことを確認
  validates :body, presence: true
  # タグが空白じゃないことを確認
  validate :invalid_note_tag
  # タグは6個まで登録できる
  validate :invalid_note_tag_size

  # 既にいいねを押しているかのチェック
  def favorited_by?(user)
    note_favorites.where(user_id: user.id).exists?
  end

  # タグが存在しているかチェックするインスタンス変数を定義(default:false)
  @taglist_count = 0

  # 画面から受け取ったパラメータのtag_listが存在しなければtaglist_chkをtrueに変更する
  def set_taglist_exist(tag_list)
    @taglist_count = tag_list
  end

  # 実際のバリデーションを行うメソッド
  def invalid_note_tag
    return unless @taglist_chk

    errors[:base] << 'タグが入力されていません'
  end

  # タグは6つまで登録できる
  def invalid_note_tag_size
    return unless @taglist_count > 6

    errors[:base] << 'タグは6つまで登録できます'
  end

end
