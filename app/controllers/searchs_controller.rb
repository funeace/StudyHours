class SearchsController < ApplicationController
  def index
    # デフォルト設定
    @users = User.all.order(id: "DESC")
    @notes = Note.all.order(id: "DESC")
    @study_logs = StudyLog.all.order(id: "DESC")
  end

  def sort
    # binding.pry
    @users = User.all.order(id: "DESC")
    @notes = Note.all.order(id: "DESC")
    @study_logs = StudyLog.all.order(id: "DESC")

    sort = params[:sort_id]
    case sort
    # お気に入り順に並び替える
    when "study_favorite_sort" then
      @study_logs = StudyLog.find(StudyLogFavorite.group(:study_log_id).order('count(study_log_id) desc').pluck(:study_log_id))
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
    when "study_created_sort" then
      @study_logs = StudyLog.all.order(id: "DESC")      
    end

    respond_to do |format|
      format.json
    end
  end
end
