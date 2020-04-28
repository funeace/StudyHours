class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:detail,:show,:following,:followers,:favorites]
  before_action :correct_user,only: [:edit]

  def show
    @user = User.find(params[:id])
    @notes = @user.notes
    @study_logs = @user.study_logs

    # ユーザがログインしている場合、DM機能でroomを作成するため判定を行う
    # gonにデータを渡す処理
    # 進捗率を表示(目標がない場合はとりあえず0)
    gon.labels =[]
    gon.data = []
    gon.background = []
    gon.progress = @user.weekly_progress

    # 自分の投稿情報を集計して配列で返すメソッド(chart_create)
    @user.chart_create.each do |chart|
      gon.labels.push(chart[0])
      gon.background.push(chart[1])
      gon.data.push(chart[2])
    end
    gon.all_variables
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # binding.pry
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to timelines_path
    else
      render 'edit'
    end
  end

  # フォロー中ユーザの一覧
  def following
    @users = User.find(params[:id]).followings
  end

  # フォロワーの一覧
  def followers
    @users = User.find(params[:id]).followers
  end

  def favorites
    @user = User.find(params[:id])
    @study_logs = []
    @notes = []

    study_favorites = @user.study_log_favorites
    study_favorites.each do |favorite|
      @study_logs.push(favorite.study_log)
    end

    note_favorites = @user.note_favorites
    note_favorites.each do |favorite|
      @notes.push(favorite.note)
    end
  end

private
  def user_params
    params.require(:user).permit(:name,:email,:goal_hour,:goal_minute,:introduction,:profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to root_path
    end
  end
end
