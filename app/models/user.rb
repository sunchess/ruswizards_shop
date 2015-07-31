class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_products
  has_many :products, through: :users_products
  has_many :orders

  validates :fullname, presence: true

  def self.products_in_cart user_id, users_products_ids = nil
    filter = {user_id: user_id}
    filter[:id] = users_products_ids if users_products_ids

    user_products = Product.joins(:users_products).select("products.*, users_products.*").distinct.where(users_products: filter)
    user_products.map &:attributes
  end

  def products_in_orders
    order_products = orders.joins(:orders_products).joins(:products).select("products.*, orders_products.*").distinct
    order_products.map &:attributes
  end
end
