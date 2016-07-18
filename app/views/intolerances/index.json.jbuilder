json.array!(@intolerances) do |intolerance|
  json.extract! intolerance, :id, :name, :minor_symptom, :medium_symptom, :major_symptom, :key_component
  json.url intolerance_url(intolerance, format: :json)
end
