json.array!(@families) do |family|
  json.extract! family, :id, :name, :user_id
  json.url family_url(family, format: :json)
end
