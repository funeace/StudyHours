class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:twitter,:google]

  # ノートのアソシエーション
  has_many :notes ,dependent: :destroy
  has_many :note_favorites ,dependent: :destroy
  has_many :note_comments ,dependent: :destroy

  #　学習記録のアソシエーション
  has_many :study_logs ,dependent: :destroy
  has_many :study_log_favorites ,dependent: :destroy
  has_many :study_log_comments ,dependent: :destroy

  # フォロー・フォロワーのアソシエーション
  has_many :relationships
  has_many :followings,through: :relationships,source: :follow
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: 'follow_id'
  has_many :followers,through: :reverse_of_relationships, source: :user
  has_many :entries
  has_many :rooms, through: :entries
  has_many :chats

  attachment :profile_image

  def following?(user)
    self.followings.include?(user)
  end

  def follow(user)
    if self.following?(user) == false
      self.relationships.create(follow_id: user.id)
    end
  end

  def unfollow(user)
    self.relationships.find_by(follow_id: user.id).destroy
  end

protected
  def self.from_omniauth(auth)
    # twitterの場合メールアドレスが持ってこれないため、ダミーデータが登録されている
    if auth.provider == :twitter
      user = User.find_by(email: User.dummy_email(auth))
    else
      user = User.find_by(email: auth.info.email)
    end

    unless user
      case auth.provider
      when :twitter then 
        user = User.create(provider: auth.provider,uid: auth.uid,email: User.dummy_email(auth),name: auth.info.name,password: Devise.friendly_token[0,20])
      when :google then
        user = User.create(provider: auth.provider,uid: auth.uid,email: auth.info.email,name: auth.info.name,password: Devise.friendly_token[0,20])
      end
    end
    user
  end

# Twitterのアカウントはemailがnilとなってしまうため、ダミーを用意する
  def self.dummy_email(auth)
    return "#{auth.uid}-#{auth.provider}@dummy.co.jp"
  end
end
