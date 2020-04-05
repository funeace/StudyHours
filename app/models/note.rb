class Note < ApplicationRecord
  belongs_to :user
  has_many :note_favorites,dependent: :destroy
  has_many :note_comments,dependent: :destroy
end
