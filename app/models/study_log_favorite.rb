class StudyLogFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :study_log

  validates :study_log_id, uniqueness: { scope: :user_id }
end
