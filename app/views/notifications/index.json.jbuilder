json.array!(@notifications) do |notification|
  json.extract! notification, :id, :from_type, :from_id, :message
  json.url notification_url(notification, format: :json)
end
