class StudyLogFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :study_log
  # 勉強記録idとuseridが一意であることを確認
  validates :study_log_id, uniqueness: { scope: :user_id }
end
