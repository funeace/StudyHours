class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ノートのアソシエーション
  has_many :notes ,dependent: :destroy
  has_many :note_favorites ,dependent: :destroy
  has_many :note_comments ,dependent: :destroy

  #　学習記録のアソシエーション
  has_many :records ,dependent: :destroy
  has_many :record_favorites ,dependent: :destroy
  has_many :record_comments ,dependent: :destroy

  # フォロー・フォロワーのアソシエーション
  has_many :relationships
  has_many :followings,through: :relationships,source: :follow
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: 'follow_id'
  has_many :followers,through: :reverse_of_relationships, source: :user

end
