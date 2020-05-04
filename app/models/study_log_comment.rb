class StudyLogComment < ApplicationRecord
  belongs_to :user
  belongs_to :study_log
  has_many :notifications, dependent: :destroy
  
  validates :user_id, presence: true
  validates :comment, presence: true
end
