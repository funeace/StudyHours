class Record < ApplicationRecord
  belongs_to :user
  has_many :record_favorites ,dependent: :destroy
  has_many :record_comments ,dependent: :destroy
end
