class Notification < ApplicationRecord
  #新着順に並ぶようスコープを定義
  default_scope ->{order(created_at: :desc)}
  belongs_to :user
  belongs_to :visit,class_name: "User", foreign_key: 'visit_id'
  # 以下は外部キーがnullの可能性があるのでoptional: trueを指定
  belongs_to :study_log_favorite,optional: true
  belongs_to :study_log_comment,optional: true
  belongs_to :note_favorite,optional: true
  belongs_to :note_comment,optional: true

  # user_idが空白じゃない
  validates :user_id, presence: true
  # visit_idが空白じゃない
  validates :user_id, presence: true
  # visit_idが空白じゃない
  validates :action, presence: true

end
