json.array!(@products) do |product|
  json.extract! product, :id, :name, :barcode
  json.url product_url(product, format: :json)
end
