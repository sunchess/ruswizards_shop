class AddPriceToUsersProducts < ActiveRecord::Migration
  def change
    add_column :users_products, :price, :float
  end
end
