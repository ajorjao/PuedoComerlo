json.array!(@comments) do |comment|
  json.extract! comment, :id, :title, :description, :likes, :dislikes, :parent_comment
  json.url comment_url(comment, format: :json)
end
