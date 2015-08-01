class Product < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  has_many :users_products
  has_many :users, through: :users_products

  has_many :orders_products
  has_many :orders, through: :orders_products
  
  belongs_to :category

  validates :title, presence: true, length: { minimum: 3 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def category_title
    category.title
  end

  def self.filter filter
    result = {}
    if filter
      if filter["price_from"] or filter["price_to"]
        price_from = filter["price_from"].to_f || 0.0 rescue 0.0
        price_to =  if filter["price_to"].present?
                      filter["price_to"].to_f
                    else
                      999999999999.0
                    end
        result[:price] = (price_from..price_to)
      end

      if filter["category_id"]
        ids = filter["category_id"].reject{|k, v| !v}.keys
        result[:category_id] = ids if ids.length!=0
      end
    end

    result
  end

  def count
    users_products.first.count
  end
end
