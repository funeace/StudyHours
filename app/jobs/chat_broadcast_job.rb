class ChatBroadcastJob < ApplicationJob
  queue_as :default

  # データ保存後に画面を更新する処理
  def perform(chat, current_user)
    ActionCable.server.broadcast("room_channel_#{chat.room_id}", chat: render_chat(chat, current_user))
  end

  private

  # コントローラからrenderを行うための処理
  def render_chat(chat, current_user)
    if current_user == chat.user_id
      # ログインユーザーなので右側向けのcssを追加する
      ApplicationController.renderer.render(partial: 'chats/login_user', locals: { chat: chat, user: current_user })
    else
      # 他のユーザーなので左側に表示する
      ApplicationController.renderer.render(partial: 'chats/other_user', locals: { chat: chat, user: current_user })
    end
  end
end
