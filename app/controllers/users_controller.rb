class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[detail show following followers favorites]
  before_action :correct_user, only: %i[edit]

  def show
    @user = User.find(params[:id])

    @notes = @user.notes
                  .order(id: 'DESC')
                  .page(params[:study_log_page])
                  .per(6)

    @study_logs = @user.study_logs
                       .order(id: 'DESC')
                       .page(params[:study_log_page])
                       .per(6)


    # jsにgonを使ってデータを渡す処理
    gon.labels = []
    gon.data = []
    gon.background = []
    gon.progress = @user.weekly_progress

    # 以下は自分の投稿情報を集計して配列で送っている
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
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to timelines_path
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
    params.require(:user).permit(:name, :email, :goal_hour, :goal_minute, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id == @user.id
  end
end
