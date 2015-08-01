class AddPriceToOrdersProducts < ActiveRecord::Migration
  def change
    add_column :orders_products, :price, :float
  end
end
