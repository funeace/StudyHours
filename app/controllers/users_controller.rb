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

  # ユーザの詳細ページ
  def detail
    @user = User.find(params[:id])
    study_data =[]
    chart_data = []
    gon.labels =[]
    gon.data = []

    # ユーザの投稿内容に紐づいたtagを取得する処理
    @user.study_logs.each do |study_log|
      study_data.push(study_log.study_log_details.tags_on(:tags))
    end
    # ユーザが投稿したタグの情報を全て取得
    study_data.each do |sdata|
      sdata.length.times do |i|
        chart_data.push(sdata[i].name)
      end
    end

    # gonにデータを渡す処理
    # 進捗率を表示(目標がない場合はとりあえず0)
    gon.progress = @user.weekly_progress

    chart_data.group_by(&:itself).map{ |k, v| [k, v.size] }.each do |chart|
      gon.labels.push(chart[0])
      gon.data.push(chart[1])
    end
    gon.background = ["#000","#111","#222","#333","#444","#555","#666"]
    gon.all_variables 
  end

  # フォロー中ユーザの一覧
  def following
    @users = User.find(params[:id]).followings
  end

  # フォロワーの一覧
  def followers
    @users = User.find(params[:id]).followers
  end

private
  def user_params
  params.require(:user).permit(:name,:email,:goal_hour,:goal_minute,:introduction,:profile_image)
  end
end
