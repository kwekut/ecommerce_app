json.array!(@products) do |product|
  json.extract! product, :id, :product_title, :product_info
  json.url product_url(product, format: :json)
end
