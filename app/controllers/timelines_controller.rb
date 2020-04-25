class TimelinesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    # 自身のユーザまたは、自身がフォローしているユーザ情報の投稿一覧を表示
    @notes = Note.where("user_id = ? OR user_id IN (?)",@user.id, @user.followings.ids).order(id: "DESC").page(params[:note_page]).per(5)
    @study_logs = StudyLog.where("user_id = ? OR user_id IN (?)",@user.id,@user.followings.ids).order(id: "DESC").page(params[:study_log_page]).per(6)


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
end
