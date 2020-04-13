class SearchsController < ApplicationController
  def index
    # デフォルト設定
    @users = User.all.order(id: "DESC")
    @notes = Note.all.order(id: "DESC")
    @study_logs = StudyLog.all.order(id: "DESC")
  end


  # 本当は以下の形にしたい(メソッド作る）
  # SELECT
  #   a.study_log_id
  #   NVL(count(b.study_log_id),0)
  # FROM
  #   StudyLog a
  #   StudyLogFavorite b
  # WHERE
  #   a.id = b.study_log_id(+)
  #
  def sort
    # binding.pry
    @user = current_user
    @users = User.all.order(id: "DESC")
    @notes = Note.all.order(id: "DESC")
    @study_logs = StudyLog.all.order(id: "DESC")
    # binding.pry

    sort = params[:sort_id]
    case sort
    # お気に入り順に並び替える
    when "study_favorite_sort" then
      @study_logs = StudyLog.find(StudyLogFavorite.group(:study_log_id).order('count(study_log_id) desc').pluck(:study_log_id))
    # 作成日順
    when "study_created_sort" then
      @study_logs = StudyLog.all.order(id: "DESC")
    # ノートお気に入り順
    when "note_favorite_sort" then
      @notes = Note.find(NoteFavorite.group(:note_id).order('count(note_id) desc').pluck(:note_id))
    # ノート作成日順
    when "note_created_sort" then
      @notes = Note.all.order(id:"DESC")
    # フォロワー数
    when "user_follower_sort" then
      @users = User.find(Relationship.group(:follow_id).order('count(follow_id) desc').pluck(:follow_id))
    # ユーザ作成日順
    when "user_created_sort" then
      @users = User.all.order(id: "DESC")
    end
    respond_to do |format|
      format.json
    end
  end

  def search
    @user = current_user
    @users = User.where('name LIKE(?)',"%#{params[:keyword]}%")
    @notes = Note.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))
    @study_logs = StudyLog.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))
    # binding.pry

    respond_to do |format|
      format.json
    end
  end
end
