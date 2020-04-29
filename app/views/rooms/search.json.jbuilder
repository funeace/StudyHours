json.rooms_length @users_length
json.users @users do |user|
  json.id user.id
  json.name user.name
  json.introduction user.introduction
  json.profile_image Refile.attachment_url(user, :profile_image)
end
