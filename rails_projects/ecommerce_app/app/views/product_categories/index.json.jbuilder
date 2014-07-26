json.array!(@product_categories) do |product_category|
  json.extract! product_category, :id, :product_group, :product_subgroup, :product_type, :product_gender, :other
  json.url product_category_url(product_category, format: :json)
end
