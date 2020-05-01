class StudyLog < ApplicationRecord
  belongs_to :user
  has_many :study_log_favorites, dependent: :destroy
  has_many :study_log_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  acts_as_taggable

  # 作業日が入力されている
  validates :working_date, presence: true
  # ユーザIDが存在していることを確認
  validates :user_id, presence: true
  # 時間(hour)が存在していることを確認
  validates :hour, presence: true
  # 時間(minute)が存在していることを確認
  validates :minute, presence: true
  # memoは50文字まで
  validates :memo, length: { maximum: 50 }
  # 学習合計時間が0じゃない
  validate :invalid_working_date
  # tagが入力されている
  validate :invalid_study_tag
  # 学習時間の合計が0じゃない  validate :invalid_study_hours
  validate :invalid_study_hours
  # タグは6個まで登録できる
  validate :invalid_study_tag_size

  # 既にいいね ボタンを押しているか確認
  def favorited_by?(user)
    study_log_favorites.where(user_id: user.id).exists?
  end

  # タグの存在確認
  # タグが存在しているかチェックするインスタンス変数を定義(default:false)
  @taglist_count = 0
  # 画面から受け取ったパラメータのtag_listが存在しなければtaglist_chkをtrueに変更する
  def set_taglist_exist(tag_list)
    @taglist_count = tag_list
  end

  # 実際のバリデーションを行うメソッド
  # 学習内容のタグがnullだったらエラー
  def invalid_study_tag
    return unless @taglist_count.zero?

    errors[:base] << '学習内容が入力されていません'
  end

  def invalid_study_tag_size
    return unless @taglist_count > 6

    errors[:base] << '学習内容は6つまで登録できます'
  end


  private

  # 未来日の登録を防ぐバリデーション
  def invalid_working_date
    return unless working_date.present? && working_date > Date.today

    errors[:base] << '未来日は入力できません'
  end

  # 学習時間が0を防ぐバリデーション
  def invalid_study_hours
    return unless hour.zero? && minute.zero?

    errors[:base] << '学習時間を入力してください'
  end
end
