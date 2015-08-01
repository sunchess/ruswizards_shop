json.array!(@products) do |product|
  json.extract! product, :id, :title, :description, :price, :category_title, :photo
  json.url product_url(product, format: :json)
end
