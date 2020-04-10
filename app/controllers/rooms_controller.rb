class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
    @entries = @room.entries
  end

  def create
    @user = User.find(params[:user_id])
    @new_room = Room.create
    # binding.pry
    entry1 = Entry.create(user_id: @user.id,room_id: @new_room.id)
    entry2 = Entry.create(user_id: current_user.id,room_id: @new_room.id)
    redirect_to room_path(@new_room.id)
  end
end
