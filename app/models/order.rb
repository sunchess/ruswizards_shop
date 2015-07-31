class Order < ActiveRecord::Base
  has_many :orders_products
  has_many :products, through: :orders_products
  belongs_to :user

  validates :address, presence: true
  validates :phone, presence: true
  validates :fullname, presence: true
end
