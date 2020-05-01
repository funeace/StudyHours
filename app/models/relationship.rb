class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  # user_idとfollow_idが一意であることを確認
  validates :follow_id, uniqueness: { scope: :user_id }
end
