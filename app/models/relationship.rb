class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :follow_id, uniqueness: { scope: :user_id }
end
