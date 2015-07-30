class AddOrderIdToUsersProducts < ActiveRecord::Migration
  def change
    add_column :users_products, :order_id, :integer
  end
end
