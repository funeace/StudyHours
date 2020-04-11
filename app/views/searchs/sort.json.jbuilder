json.study_logs @study_logs do |study_log|
  json.id study_log.id
  json.working_date study_log.working_date
  json.memo study_log.memo
  json.user do
    json.id study_log.user.id
    json.name study_log.user.name
    json.profile_image study_log.user.profile_image
  end
  json.study_log_details study_log.study_log_details do |study_log_detail|
    json.id study_log_detail.id
    json.hour study_log_detail.hour
    json.min study_log_detail.min
    json.tags study_log_detail.tag_list do |tag_list|
      json.tag tag_list
    end                                                                                                                            
  end
end
# json.users @users
# json.notes @notes