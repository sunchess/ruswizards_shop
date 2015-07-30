class AddCountToUsersProducts < ActiveRecord::Migration
  def change
    add_column :users_products, :count, :integer, default: 0
  end
end
