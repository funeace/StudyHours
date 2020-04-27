json.study_logs @study_logs do |study_log|
  # ログインユーザのIDを取得
  json.current_user @user
  # study_logの情報を取得
  json.id study_log.id
  json.hour study_log.hour
  json.minute study_log.minute
  json.working_date study_log.working_date.strftime("%Y年%m月%d日")
  json.memo study_log.memo
  # ユーザ情報の取得
  json.user do
    json.id study_log.user.id
    json.name study_log.user.name
    json.profile_image Refile.attachment_url(study_log.user,:profile_image)
  end

  # 学習記録のお気に入り情報取得
  json.study_log_favorites study_log.study_log_favorites do |study_log_favorite|
    json.favorite_id study_log_favorite.id
    json.user_id study_log_favorite.user_id
  end

  json.tags study_log.tag_list do |tag_list|
    json.tag tag_list
  end                                                                                                                     
end

# ノートの取得
json.notes @notes do |note|
  json.id note.id
  json.created_at note.created_at.strftime("%Y年%m月%d日")
  json.title note.title
  json.body note.body
  # タグ情報
  json.tags note.tag_list do |tag_list|
    json.tag tag_list
  end
  # ユーザ情報
  json.user do
    json.id note.user.id
    json.name note.user.name
    json.profile_image Refile.attachment_url(note.user, :profile_image)
  end
  # ノートのコメントID
  json.note_comments note.note_comments do |note_comment|
    json.comment_id note_comment.id
  end
  # ノートのいいねID
  json.note_favorites note.note_favorites do |note_favorite|
    json.favorite_id note_favorite.id
  end
end

json.users @users do |user|
  json.id user.id
  json.profile_image Refile.attachment_url(user, :profile_image)
  json.name user.name
  json.introduction user.introduction
  json.relationships user.relationships do |relation|
    json.user_id relation.user_id
    json.follow_id relation.follow_id
  end
  json.reverse_of_relationships user.reverse_of_relationships do |relation|
    json.user_id relation.user_id
    json.follow_id relation.follow_id
  end
end