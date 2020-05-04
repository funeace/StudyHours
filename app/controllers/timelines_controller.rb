class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @notes = Note.includes(%i[user note_comments note_favorites tags])
                 .where('user_id = ? OR user_id IN (?)', @user.id, @user.followings.ids)
                 .order(id: 'DESC')
                 .page(params[:note_page])
                 .per(6)

    @study_logs = StudyLog.includes(%i[user study_log_favorites tags])
                          .where('user_id = ? OR user_id IN (?)', @user.id, @user.followings.ids)
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
end
