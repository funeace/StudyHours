class ChatBroadcastJob < ApplicationJob
  queue_as :default

  # データ保存後に画面を更新する処理
  def perform(chat)
    ActionCable.server.broadcast("room_channel_#{chat.room_id}",chat: render_chat(chat))
  end

private
  # コントローラからrenderを行うための処理
  def render_chat(chat)
    ApplicationController.renderer.render(partial: 'chats/chat',locals: { chat: chat })
  end
end
