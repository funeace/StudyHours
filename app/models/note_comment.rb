class NoteComment < ApplicationRecord
  belongs_to :user
  belongs_to :note
  has_many :notifications, dependent: :destroy

  # useridが存在していることを確認
  validates :user_id,presence: true
  # コメントが入っていることを確認
  validates :comment,presence: true

end
