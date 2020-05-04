class NoteFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :note

  validates :note_id, uniqueness: { scope: :user_id }
end
