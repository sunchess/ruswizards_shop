json.array!(@products) do |product|
  json.extract! product, :id, :title, :description, :price, :category_title, :photos
  json.url product_url(product, format: :json)
end
