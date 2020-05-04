class NoteComment < ApplicationRecord
  belongs_to :user
  belongs_to :note
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :comment, presence: true
end
