# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.where(email: "admin@admin.com")

unless admin.any?
  admin.first_or_create(password: "123123123", fullname: "Администратор магазина", address: "Россия, Москва, ул. Случайная 123", phone: "8-800-123-12-34")
  p "Создание администратора"
end
