class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:show,:detail]

  def show
    @user = User.find(params[:id])
    @notes = @user.notes
    @study_logs = @user.study_logs

    # ユーザがログインしている場合、DM機能でroomを作成するため判定を行う
    if user_signed_in? 
      current_entry = Entry.where(user_id: current_user.id)
      partner_entry = Entry.where(user_id: @user.id)

      unless @user.id == current_user.id
        # 自分とチャット先ユーザのentryテーブルを検索し、同一のroomidがあるか確認
        current_entry.each do |current|
          partner_entry.each do |partner|
            if current.room_id == partner.room_id
              @room_chk = true
              @room_id = current.room_id
            end
          end
        end
        unless @room_chk == true
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def detail
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # binding.pry
    if @user.update(user_params)
      flash[:info] = "更新しました"
      redirect_to detail_user_path(@user)
    else
      render 'edit'
    end
  end

  def following
    @users = User.find(params[:id]).followings
  end

  def followers
    @users = User.find(params[:id]).followers
  end

private
  def user_params
  params.require(:user).permit(:name,:email,:goal_hour,:goal_minute,:introduction,:profile_image)
  end
end
