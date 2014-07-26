json.array!(@shop_categories) do |shop_category|
  json.extract! shop_category, :id, :shop_category, :industry, :segment, :specialty, :product_type, :other
  json.url shop_category_url(shop_category, format: :json)
end
