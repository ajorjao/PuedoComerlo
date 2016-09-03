json.array!(@banned_users) do |banned_user|
  json.extract! banned_user, :id, :email
  json.url banned_user_url(banned_user, format: :json)
end
