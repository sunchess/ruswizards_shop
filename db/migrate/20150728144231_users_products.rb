class UsersProducts < ActiveRecord::Migration
  def change
    create_table :users_products do |t|
      t.integer :user_id
      t.integer :product_id

      t.index [:user_id, :product_id]

      t.timestamps null: false
    end
  end
end
