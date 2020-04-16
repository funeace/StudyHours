class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # binding.pry
    Chat.create(content: data['chat'],user_id: current_user.id,room_id: params['room'])
  end
end
