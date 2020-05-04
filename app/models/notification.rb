class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :visit, class_name: 'User', foreign_key: 'visit_id'
  # 以下は外部キーがnullの可能性があるのでoptional: trueを指定
  belongs_to :study_log, optional: true
  belongs_to :study_log_comment, optional: true
  belongs_to :note, optional: true
  belongs_to :note_comment, optional: true

  validates :user_id, presence: true
  validates :user_id, presence: true
  validates :action, presence: true
  validates :checked, inclusion: { in: [true, false] }
end
