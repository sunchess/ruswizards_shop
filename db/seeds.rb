# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.where email: "admin@admin.com"

unless admin.any?
  p "Создание администратора"
  admin = admin.first_or_create(password: "123123123", fullname: "Администратор", address: "Россия, Москва, ул. Случайная 123", phone: "8-800-123-12-34")
  admin.add_role :admin
end

# Categories

json_categories = [
  {
    title: "Apple iPad",
    url: "http://www.ulmart.ru/catalog/95387?sort=5&viewType=1&rec=true"
  },
  {
    title: "Apple iPhone",
    url: "http://www.ulmart.ru/search?string=apple+iphone&category=80252&sort=5&rec=false"
  },
  {
    title: "Apple Macbook",
    url: "http://www.ulmart.ru/catalog/10098212?pageNum=1&pageSize=30&sort=5&viewType=1&rec=true"
  }
]

# Products
p "Создание категорий и продуктов"
json_categories.each do |json_category|
  category = Category.where(title: json_category[:title]).first_or_create
  ap category.title

  doc = Nokogiri::HTML(open(json_category[:url]))
  doc.css('#catalogGoodsBlock .b-product').each do |node|
    price = node.css('.b-price__num')[0].content.strip.delete(' ')
    title = node.css('.b-product__title')[0].content.strip
    img = node.css('.b-product__img img')[0]["src"].gsub('small', 'mid').gsub('s.', '.')
    product = Product.where(title: title, price: price, category_id: category.id).first_or_create

    product.remote_photo_url = img
    product.save

    ap title
    ap price
  end
end