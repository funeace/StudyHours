class TimelinesController < ApplicationController
  def index
    @user = current_user
    # 自身のユーザまたは、自身がフォローしているユーザ情報の投稿一覧を表示
    @notes = Note.where("user_id = ? OR user_id IN (?)",@user.id, @user.followings.ids).order(id: "DESC")
    @study_logs = StudyLog.where("user_id = ? OR user_id IN (?)",@user.id,@user.followings.ids).order(id: "DESC")
  end
end
