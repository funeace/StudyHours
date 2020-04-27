class RoomsController < ApplicationController
  before_action :authenticate_user!
  LIMIT = 6    

  # チャットするユーザ一覧
  def index
    users_base = User.all.where.not(id: current_user.id)
    @users = users_base.limit(LIMIT)
    @users_length = users_base.size
  end

  # チャットルーム
  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
    @entries = @room.entries
  end

  # チャットルーム作成
  def create
    # ルームに入る際、必ずcreateアクションを経由させる
    @user = User.find(params[:user_id])
    if user_signed_in? 
      current_entry = Entry.where(user_id: current_user.id)
      partner_entry = Entry.where(user_id: @user.id)

      unless @user.id == current_user.id
        # 自分とチャット先ユーザのentryテーブルを検索し、同一のroomidがあるか確認。存在した場合、room_pathにリダイレクトさせ処理を終了
        current_entry.each do |current|
          partner_entry.each do |partner|
            if current.room_id == partner.room_id
              @room_chk = true
              @room_id = current.room_id
              redirect_to room_path(@room_id)
              break
            end
          end
        end
        unless @room_chk == true
          @new_room = Room.create
          # binding.pry
          entry1 = Entry.create(user_id: @user.id,room_id: @new_room.id)
          entry2 = Entry.create(user_id: current_user.id,room_id: @new_room.id)
          redirect_to room_path(@new_room.id)
        end
      end
    end
  end


# APIの処理
  # インクリメンタルサーチ
  def search
    # binding.pry
    users_base = User.where('name LIKE(?)',"%#{params[:keyword]}%").where.not(id: current_user.id)
    @users_length = users_base.size
    @users = users_base.limit(LIMIT)
    respond_to do |format|
      format.json
    end
  end
  
  # インクリメンタルサーチを解除する処理
  def return
    @users = User.all.where.not(id: current_user.id).limit(LIMIT)
    respond_to do |format|
      format.json
    end
  end

  def more
    offset = params[:offset]
    # binding.pry
    @users = User.all.where.not(id: current_user.id).limit(LIMIT).offset(offset)
    respond_to do |format|
      format.json
    end
  end
end
