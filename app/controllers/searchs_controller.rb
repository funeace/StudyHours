class SearchsController < ApplicationController
  # デフォルト設定
  def index
    @search_id = params[:search_id]
    @tag_name = params[:tag_name]
    case @search_id
      when nil
        @users = User.all.order(id: "DESC")
        @notes = Note.all.order(id: "DESC")
        @study_logs = StudyLog.all.order(id: "DESC")
      when "1"
        @users = User.all.order(id: "DESC")
        @notes = Note.tagged_with(@tag_name)
        @study_logs = []
        StudyLogDetail.tagged_with(@tag_name).each do |detail|
          @study_logs.push(detail.study_log)
        end
      end
    # binding.pry
  end

  # ユーザソート
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
      @study_logs =  StudyLog.all.left_joins(:study_log_favorites).group(:id).select('study_logs.*,COUNT("study_log_favorites"."id") AS favorites_count').order(favorites_count: "DESC")
    # 作成日順
    when "study_created_sort" then
      @study_logs = StudyLog.all.order(id: "DESC")
    # ノートお気に入り順
    when "note_favorite_sort" then
      @notes = Note.all.left_joins(:note_favorites).group(:id).select('notes.*,COUNT("note_favorites"."id") AS note_count').order(note_count: "DESC")
    # ノート作成日順
    when "note_created_sort" then
      @notes = Note.all.order(id:"DESC")
    # フォロワー数
    when "user_follower_sort" then
      @users = User.all.left_joins(:reverse_of_relationships).group(:id).select('users.*,COUNT("relationships"."id") AS follower_count').order(follower_count: "DESC")
      # ユーザ作成日順
    when "user_created_sort" then
      @users = User.all.order(id: "DESC")
    end
    respond_to do |format|
      format.json
    end
  end

  # ユーザ検索
  def search
    genre = params[:genre]
    # binding.pry
    # 名前検索
    @user = current_user
    if genre == "name"
      @users = User.where('name LIKE(?)',"%#{params[:keyword]}%")
      @notes = Note.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))
      @study_logs = StudyLog.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))
    # binding.pry
    # タグ検索(名前は引かない)
    elsif(genre =="tag")
      @users = User.all
      @study_logs = []
      # binding.pry
      StudyLogDetail.tagged_with(params[:keyword]).each do |detail|
        @study_logs.push(detail.study_log)
      end
      @notes = Note.tagged_with(params[:keyword])
    end
    # タグ検索
    respond_to do |format|
      format.json
    end
  end
end
