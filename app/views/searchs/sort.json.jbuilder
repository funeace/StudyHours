json.study_logs @study_logs do |study_log|
  # study_logの情報を取得
  json.id study_log.id
  json.working_date study_log.working_date
  json.memo study_log.memo
  # ユーザ情報の取得
  json.user do
    json.id study_log.user.id
    json.name study_log.user.name
    json.profile_image study_log.user.profile_image_id
  end
  # ノート詳細情報の取得
  json.study_log_details study_log.study_log_details do |study_log_detail|
    json.id study_log_detail.id
    json.hour study_log_detail.hour
    json.min study_log_detail.min
    # ノート詳細情報のタグの取得
    json.tags study_log_detail.tag_list do |tag_list|
      json.tag tag_list
    end                                                                                                                            
  end
end

# ノートの取得
json.notes @notes do |note|
  json.id note.id
  json.created_at note.created_at
  json.title note.title
  json.body note.body
  # タグ情報
  json.tags note.tag_list do |tag_list|
    json.tag tag_list
  end
  # ユーザ情報
  json.user do
    json.profile_image note.user.profile_image_id
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
# json.users @users
# json.notes @notes