class UsersProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  before_save :calculate_discount

  private
    def calculate_discount
      product = Product.find self.product_id
      category = product.category

      if category.discount_count && category.discount_count <= self.count
        discount = category.discount_percent 
      else
        discount = 0
      end

      self.price = self.count * product.price * (1 - discount/100)
    end
end
