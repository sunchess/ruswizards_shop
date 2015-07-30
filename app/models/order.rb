class Order < ActiveRecord::Base
  has_many :users_products
  has_many :products, through: :users_products
  belongs_to :user
end
