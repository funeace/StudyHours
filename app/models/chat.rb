class Chat < ApplicationRecord
  # データ更新後にChatBroadcastJobが実行され、投稿と同時に画面に表示される
  after_create_commit { ChatBroadcastJob.perform_later(self, user_id) }
  belongs_to :room
  belongs_to :user
  validates :content, presence: true
end
