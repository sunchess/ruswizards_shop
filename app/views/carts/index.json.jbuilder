json.array!(@products) do |product|
  json.extract! product, :id, :title, :description, :price, :category_title, :count, :photos
end