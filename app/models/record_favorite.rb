class RecordFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :note
end
