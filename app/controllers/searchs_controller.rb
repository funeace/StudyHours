class SearchsController < ApplicationController
  LIMIT = 6
  # デフォルト設定
  def index
    @search_id = params[:search_id]
    @tag_name = params[:tag_name]
    @study_logs_length = StudyLog.all.size
    @note_length = StudyLog.all.size
    @user_length = User.all.size
    case @search_id
    when nil
      @users = User.all.order(id: "DESC").limit(LIMIT)
      @notes = Note.all.order(id: "DESC").limit(LIMIT)
      @study_logs = StudyLog.all.order(id: "DESC").limit(LIMIT)
    when "1"
      @users = User.all.order(id: "DESC").limit(LIMIT)
      @notes = Note.tagged_with(@tag_name).limit(LIMIT)
      @study_logs = []
      StudyLogDetail.tagged_with(@tag_name).each do |detail|
        @study_logs.push(detail.study_log).limit(LIMIT)
      end
    end
  end

  # もっと見るを押した時の処理
  def more
    # 画面から受け取ったdata-lengthの値
    @user = current_user
    @users = User.all.order(id: "DESC").limit(LIMIT)
    @notes = Note.all.order(id: "DESC").limit(LIMIT)
    @study_logs = StudyLog.all.order(id: "DESC").limit(LIMIT)

    sort = params[:sort]
    offset = params[:offset]

    case sort
    # 学習記録通常時
    when "study_log_default" then
      @study_logs = StudyLog.all.order(id: "DESC").limit(LIMIT).offset(offset)
    # お気に入り順に並び替える
    when "study_favorite_sort" then
      @study_logs =  StudyLog.all.left_joins(:study_log_favorites).group(:id).select('study_logs.*,COUNT("study_log_favorites"."id") AS favorites_count').order(favorites_count: "DESC").limit(LIMIT).offset(offset)
    # 作成日順
    when "study_created_sort" then
      @study_logs = StudyLog.all.order(id: "DESC").limit(LIMIT).offset(offset)
    # ノート通常時
    when "note_default" then
      @notes = Note.all.order(id:"DESC").limit(LIMIT).offset(offset)
    # ノートお気に入り順
    when "note_favorite_sort" then
      @notes = Note.all.left_joins(:note_favorites).group(:id).select('notes.*,COUNT("note_favorites"."id") AS note_count').order(note_count: "DESC").limit(LIMIT).offset(offset)
    # ノート作成日順
    when "note_created_sort" then
      @notes = Note.all.order(id:"DESC").limit(LIMIT).offset(offset)
    # ユーザ通常時
    when "user_default" then
      @users = User.all.order(id: "DESC").limit(LIMIT).offset(offset)
    # フォロワー数
    when "user_follower_sort" then
      @users = User.all.left_joins(:reverse_of_relationships).group(:id).select('users.*,COUNT("relationships"."id") AS follower_count').order(follower_count: "DESC").limit(LIMIT).offset(offset)
      # ユーザ作成日順
    when "user_created_sort" then
      @users = User.all.order(id: "DESC").limit(LIMIT).offset(offset)
    end
    respond_to do |format|
      format.json
    end
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
      @study_logs =  StudyLog.all.left_joins(:study_log_favorites).group(:id).select('study_logs.*,COUNT("study_log_favorites"."id") AS favorites_count').order(favorites_count: "DESC").limit(LIMIT)
    # 作成日順
    when "study_created_sort" then
      @study_logs = StudyLog.all.order(id: "DESC").limit(LIMIT)
    # ノートお気に入り順
    when "note_favorite_sort" then
      @notes = Note.all.left_joins(:note_favorites).group(:id).select('notes.*,COUNT("note_favorites"."id") AS note_count').order(note_count: "DESC").limit(LIMIT)
    # ノート作成日順
    when "note_created_sort" then
      @notes = Note.all.order(id:"DESC").limit(LIMIT)
    # フォロワー数
    when "user_follower_sort" then
      @users = User.all.left_joins(:reverse_of_relationships).group(:id).select('users.*,COUNT("relationships"."id") AS follower_count').order(follower_count: "DESC").limit(LIMIT)
      # ユーザ作成日順
    when "user_created_sort" then
      @users = User.all.order(id: "DESC").limit(LIMIT)
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
    # ノート検索
    elsif genre == "note"
      @users = User.all
      @study_logs = StudyLog.all
      @notes = Note.where('title LIKE(?)',"%#{params[:keyword]}%")

    # タグ検索(名前は引かない)      
    elsif genre =="tag"
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
