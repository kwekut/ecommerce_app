json.array!(@shops) do |shop|
  json.extract! shop, :id, :shop_title, :shop_info
  json.url shop_url(shop, format: :json)
end
