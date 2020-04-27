class SearchsController < ApplicationController
  LIMIT = 6
  # デフォルト設定
  def index
    @search_id = params[:search_id]
    @tag_name = params[:tag_name]

    # 共通して検索する項目をベースとして定義
    users_base = User.all.includes([:relationships]).order(id: "DESC")
    notes_base = Note.all.includes([:user,:note_comments,:note_favorites,:tags]).order(id: "DESC")
    study_logs_base = StudyLog.all.includes([:user,:study_log_favorites,:tags]).order(id: "DESC")

    # ページネーションのボタンをdisabledにするため、取得した要素の件数を取得    
    @study_log_length = study_logs_base.size
    @note_length = notes_base.size
    @user_length = users_base.size
    # 画面から受け取ったsearch_idがnilの場合は全件表示
    case @search_id
    when nil
      @users = users_base.limit(LIMIT)
      @notes = notes_base.limit(LIMIT)
      @study_logs = study_logs_base.limit(LIMIT)

    # tagで検索情報を受け取った時はtagに紐づいた情報を表示
    when "1"
      @users = users_base.limit(LIMIT)
      @notes = notes_base.tagged_with(@tag_name).limit(LIMIT)
      @study_logs = study_logs_base.tagged_with(@tag_name).limit(LIMIT)
    end
  end

  # ユーザの並び替えが押された時に実行する処理(ajax)
  def sort
    # binding.pry
    if user_signed_in?
      @user = current_user.id
    else
      @user = "Guest"
    end
    @users = User.all.includes([:relationships,:reverse_of_relationships]).order(id: "DESC").limit(LIMIT)
    @notes = Note.all.includes([:user,:note_comments,:note_favorites,:tags]).order(id: "DESC").limit(LIMIT)
    @study_logs = StudyLog.all.includes([:user,:study_log_favorites,:tags]).order(id: "DESC").limit(LIMIT)
    # binding.pry

    sort = params[:sort_id]
    case sort
    # お気に入り順に並び替える
    when "study_favorite_sort" then
      @study_logs = StudyLog.all.left_joins(:study_log_favorites).group(:id).select('study_logs.*,COUNT("study_log_favorites"."id") AS favorites_count').order(favorites_count: "DESC").limit(LIMIT)
    # 作成日順
    when "study_created_sort" then
      @study_logs
    # ノートお気に入り順
    when "note_favorite_sort" then
      @notes = Note.all.left_joins(:note_favorites).group(:id).select('notes.*,COUNT("note_favorites"."id") AS note_count').order(note_count: "DESC").limit(LIMIT)
    # ノート作成日順
    when "note_created_sort" then
      @notes
    # フォロワー数
    when "user_follower_sort" then
      @users = User.all.left_joins(:reverse_of_relationships).group(:id).select('users.*,COUNT("relationships"."id") AS follower_count').order(follower_count: "DESC").limit(LIMIT)
      # ユーザ作成日順
    when "user_created_sort" then
      @users
    end
    respond_to do |format|
      format.json
    end
  end

  # ユーザ検索(ajax)
  def search
    genre = params[:genre]
    # binding.pry
    if user_signed_in?
      @user = current_user.id
    else
      @user = "Guest"
    end
    # 名前検索が行われた場合
    if genre == "name"
      # 共通して検索する項目をベースとして定義
      users_base = User.where('name LIKE(?)',"%#{params[:keyword]}%")
      notes_base = Note.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))
      study_log_base = StudyLog.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%"))

      # ページネーションのボタンをdisabledにするため、取得した要素の件数を取得
      @user_length = users_base.size
      @note_length = notes_base.size
      @study_log_length = study_log_base.size
      # 検索する処理
      @users = users_base.limit(LIMIT)
      @notes = notes_base.limit(LIMIT)
      @study_logs = study_log_base.limit(LIMIT)
    # ノート検索
    elsif genre == "note"
      # 共通して検索する項目をベースとして定義
      users_base = User.all.includes([:relationships,:reverse_of_relationships]).order(id: "DESC")
      study_logs_base = StudyLog.all.includes([:user,:study_log_favorites,:tags]).order(id: "DESC")
      notes_base = Note.where('title LIKE(?)',"%#{params[:keyword]}%").order(id: "DESC")
      # ページネーションのボタンをdisabledにするため、取得した要素の件数を取得
      @user_length = users_base.size
      @study_log_length = study_logs_base.size
      @note_length = note_base.size
      # 検索する処理
      @users = users_base.limit(LIMIT)
      @study_logs = study_logs_base.limit(LIMIT)
      @notes = notee_base.limit(LIMIT)
    # タグ検索(名前は引かない)
    elsif genre =="tag"
      # 共通して検索する項目をベースとして定義
      users_base = User.all.includes([:relationships,:reverse_of_relationships]).order(id: "DESC")
      study_logs_base = StudyLog.tagged_with(params[:keyword])
      notes_base = Note.tagged_with(params[:keyword])
      # ページネーションのボタンをdisabledにするため、取得した要素の件数を取得
      @user_log_length = users_base.size
      @study_log_length = study_logs_base.size
      @note_length = notes_base.size
      # 検索する処理
      @users = users_base.limit(LIMIT)
      @study_logs =  study_logs_base.limit(LIMIT)
      @notes = notes_base.limit(LIMIT)
    end
    # タグ検索
    respond_to do |format|
      format.json
    end
  end

    # もっと見るを押した時の処理(ajax)
  def more
    # 各々のデータ
    if user_signed_in?
      @user = current_user.id
    else
      @user = "Guest"
    end
    @users = User.all.includes([:relationships,:reverse_of_relationships]).order(id: "DESC").limit(LIMIT)
    @notes = Note.all.includes([:user,:note_comments,:note_favorites,:tags]).order(id:"DESC").limit(LIMIT)
    @study_logs = StudyLog.all.includes([:user,:study_log_favorites,:tags]).order(id: "DESC").limit(LIMIT)
    
    sort = params[:sort]
    offset = params[:offset]
    keyword = params[:keyword]
    genre = params[:genre]

    # keywordに値が入っていない時の処理
    if keyword.length == 0
      case sort
      # 学習記録通常時
      when "study_log_default" then
        @study_logs = @study_logs.offset(offset)
      # お気に入り順に並び替える
      when "study_favorite_sort" then
        @study_logs = StudyLog.all.includes([:user,:tags]).left_joins(:study_log_favorites).group(:id).select('study_logs.*,COUNT("study_log_favorites"."id") AS favorites_count').order(favorites_count: "DESC").limit(LIMIT).offset(offset)
      # 作成日順
      when "study_created_sort" then
        @study_logs = @study_logs.offset(offset)
      # ノート通常時
      when "note_default" then
        @notes = @notes.offset(offset)
      # ノートお気に入り順
      when "note_favorite_sort" then
        @notes = Note.all.includes([:user,:note_comments,:tags]).left_joins(:note_favorites).group(:id).select('notes.*,COUNT("note_favorites"."id") AS note_count').order(note_count: "DESC").limit(LIMIT).offset(offset)
      # ノート作成日順
      when "note_created_sort" then
        @notes = @notes.offset(offset)
      # ユーザ通常時
      when "user_default" then
        @users =  @users.offset(offset)
      # フォロワー数
      when "user_follower_sort" then
        @users = User.all.includes([:relationships]).left_joins(:reverse_of_relationships).group(:id).select('users.*,COUNT("relationships"."id") AS follower_count').order(follower_count: "DESC").limit(LIMIT).offset(offset)
        # ユーザ作成日順
      when "user_created_sort" then
        @users = @users.offset(offset)
      end
    else
      # キーワード検索の場合
      if genre == "name"
        @users = User.all.includes([:relationships]).where('name LIKE(?)',"%#{params[:keyword]}%").limit(LIMIT).offset(offset)
        @notes = Note.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%")).limit(LIMIT).offset(offset)
        @study_logs = StudyLog.joins(:user).where(user_id: User.where('name LIKE(?)',"%#{params[:keyword]}%")).limit(LIMIT).offset(offset)
        # ノート検索
      elsif genre == "note"
        @users = @users.offset(offset)
        @notes = Note.where('title LIKE(?)',"%#{params[:keyword]}%").limit(LIMIT).offset(offset)
      # タグ検索(名前は引かない)
      elsif genre =="tag"
        @study_logs = StudyLog.tagged_with(params[:keyword]).limit(LIMIT).offset(offset)
        @notes = Note.tagged_with(params[:keyword]).limit(LIMIT).offset(offset)
      end
    end
    respond_to do |format|
      format.json
    end
  end

end
