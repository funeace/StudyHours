class StudyLogComment < ApplicationRecord
  belongs_to :user
  belongs_to :study_log
  has_many :notifications, dependent: :destroy
  
  # ユーザidが存在していることを確認
  validates :user_id, presence: true
  # コメントが存在していることを確認
  validates :comment, presence: true
end
