class NoteFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :note

  # ノートidとuser_idが一意であることを確認
  validates :note_id, uniqueness: { scope: :user_id }
end
