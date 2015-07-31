module Cartable
  extend ActiveSupport::Concern

  included do

    def fetch_user_products user_id, users_products_ids = nil
      user_products = Product.joins(:users_products).select("products.*, users_products.*").distinct.where(users_products: {id: users_products_ids, user_id: user_id})
      user_products.map &:attributes
    end
  end
end